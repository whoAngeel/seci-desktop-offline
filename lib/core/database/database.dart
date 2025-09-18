import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

part 'database.g.dart';

class DailyCounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get category => text().withLength(min: 1, max: 50)();
  IntColumn get menCount => integer().withDefault(const Constant(0))();
  IntColumn get womenCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
    {date, category},
  ];
}

@DriftDatabase(tables: [DailyCounts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Futuras migraciones aquí
      },
    );
  }

  // Métodos básicos para el contador
  Future<List<DailyCount>> getCountersForDate(DateTime date) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    return (select(
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

    await into(dailyCounts).insertOnConflictUpdate(
      DailyCountsCompanion.insert(
        date: dateOnly,
        category: category,
        menCount: Value(menCount),
        womenCount: Value(womenCount),
        updatedAt: Value(DateTime.now()),
      ),
    );
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

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'biblioteca_counter.db'));
    return NativeDatabase.createInBackground(file);
  });
}
