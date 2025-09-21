import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;

part 'database.g.dart';

// Tabla de contadores diarios
class DailyCounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get category => text().withLength(min: 1, max: 50)();
  IntColumn get menCount => integer().withDefault(const Constant(0))();
  IntColumn get womenCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {date, category},
  ];
}

@DriftDatabase(tables: [DailyCounts])
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;
  static bool _isInitialized = false;

  AppDatabase._internal() : super(_createConnection());

  static Future<AppDatabase> getInstance() async {
    if (_instance == null || !_isInitialized) {
      print('📚 Database: Creando nueva instancia...');
      _instance = AppDatabase._internal();

      // FORZAR inicialización completa
      print('📚 Database: Forzando inicialización...');
      await _instance!._ensureInitialized();
      _isInitialized = true;
      print('✅ Database: Inicialización completa');
    }
    return _instance!;
  }

  // Constructor factory que devuelve la instancia
  factory AppDatabase() {
    if (_instance == null || !_isInitialized) {
      throw StateError('Database no inicializada. Usa getInstance() primero.');
    }
    return _instance!;
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        print('📚 Database: Ejecutando onCreate...');
        await m.createAll();
        print('✅ Database: onCreate completado');
      },
    );
  }

  // Método para forzar inicialización
  Future<void> _ensureInitialized() async {
    try {
      print('📚 Database: Verificando inicialización...');
      // Ejecutar una consulta simple para forzar inicialización
      await customSelect('SELECT 1').getSingleOrNull();
      print('✅ Database: Verificación exitosa');
    } catch (e) {
      print('❌ Database: Error en inicialización: $e');
      rethrow;
    }
  }

  // Métodos básicos para el contador
  Future<List<DailyCount>> getCountersForDate(DateTime date) async {
    final dateOnly = DateTime(date.year, date.month, date.day);
    return await (select(
      dailyCounts,
    )..where((tbl) => tbl.date.equals(dateOnly))).get();
  }

  Future<void> insertOrUpdateCounter({
    required DateTime date,
    required String category,
    required int menCount,
    required int womenCount,
  }) async {
    final dateOnly = DateTime(date.year, date.month, date.day);

    // Verificar si existe
    final existing =
        await (select(dailyCounts)..where(
              (tbl) =>
                  tbl.date.equals(dateOnly) & tbl.category.equals(category),
            ))
            .getSingleOrNull();

    if (existing != null) {
      // Actualizar
      await (update(
        dailyCounts,
      )..where((tbl) => tbl.id.equals(existing.id))).write(
        DailyCountsCompanion(
          menCount: Value(menCount),
          womenCount: Value(womenCount),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } else {
      // Insertar nuevo
      await into(dailyCounts).insert(
        DailyCountsCompanion.insert(
          date: dateOnly,
          category: category,
          menCount: Value(menCount),
          womenCount: Value(womenCount),
        ),
      );
    }
  }

  Future<int> getTotalForDate(DateTime date) async {
    final dateOnly = DateTime(date.year, date.month, date.day);
    final query = selectOnly(dailyCounts)
      ..addColumns([dailyCounts.menCount.sum(), dailyCounts.womenCount.sum()])
      ..where(dailyCounts.date.equals(dateOnly));

    final result = await query.getSingleOrNull();
    if (result == null) return 0;

    final menTotal = result.read(dailyCounts.menCount.sum()) ?? 0;
    final womenTotal = result.read(dailyCounts.womenCount.sum()) ?? 0;

    return menTotal + womenTotal;
  }

  Future<DateTime?> getLastRegisteredDate() async {
    final query = selectOnly(dailyCounts)..addColumns([dailyCounts.date.max()]);

    final result = await query.getSingleOrNull();
    return result?.read(dailyCounts.date.max());
  }
}

// Conexión directa y simple
QueryExecutor _createConnection() {
  // Usar directorio actual/data
  final dbPath = path.join(Directory.current.path, 'data', 'seci_counter.db');
  final file = File(dbPath);

  // Crear directorio si no existe
  final dataDir = Directory(path.dirname(dbPath));
  if (!dataDir.existsSync()) {
    dataDir.createSync(recursive: true);
  }

  print('📚 Database: Conexión directa a: $dbPath');
  return NativeDatabase(file);
}
