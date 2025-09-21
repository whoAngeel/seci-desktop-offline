import 'package:seci_desktop/core/constants.dart';
import 'package:seci_desktop/core/database/database.dart';
import 'package:seci_desktop/features/counters/domain/entities/counter_entity.dart';

class CounterRepo {
  final AppDatabase _database;

  CounterRepo(this._database);

  Future<List<CounterEntity>> getCountersForToday() async {
    print('🔍 getCountersForToday: Iniciando...');
    try {
      final today = DateTime.now();
      print('🔍 getCountersForToday: Fecha actual = $today');

      final dbCounters = await _database.getCountersForDate(today);
      print(
        '🔍 getCountersForToday: Registros encontrados = ${dbCounters.length}',
      );

      final counters = <CounterEntity>[];

      // crear lista completa con todas las categorias
      for (final category in Categories.all) {
        final dbCounter = dbCounters
            .where((element) => element.category == category)
            .firstOrNull;

        final counter = CounterEntity(
          category: category,
          menCount: dbCounter?.menCount ?? 0,
          womenCount: dbCounter?.womenCount ?? 0,
          date: DateTime(today.year, today.month, today.day),
        );

        counters.add(counter);
        print(
          '📊 Contador creado: $category -> M:${counter.menCount}, H:${counter.womenCount}',
        );
      }

      print(
        '✅ getCountersForToday: Completado con ${counters.length} contadores',
      );
      return counters;
    } catch (e) {
      print('❌ getCountersForToday: Error = $e');
      rethrow;
    }
  }

  Future<void> updateCounter({
    required String category,
    required Gender gender,
    required int increment,
  }) async {
    print(
      '🔍 updateCounter: Iniciando para $category, ${gender.name}, increment=$increment',
    );

    try {
      final today = DateTime.now();
      final dateOnly = DateTime(today.year, today.month, today.day);
      print('🔍 updateCounter: Fecha procesada = $dateOnly');

      // Paso 1: Obtener contadores actuales
      print('🔍 updateCounter: Obteniendo contadores actuales...');
      final currentCounters = await _database.getCountersForDate(dateOnly);
      print(
        '🔍 updateCounter: Contadores actuales encontrados = ${currentCounters.length}',
      );

      final currentCounter = currentCounters
          .where((element) => element.category == category)
          .firstOrNull;
      print(
        '🔍 updateCounter: Contador actual para $category = $currentCounter',
      );

      // Paso 2: Calcular nuevos valores
      int newMenCount = currentCounter?.menCount ?? 0;
      int newWomenCount = currentCounter?.womenCount ?? 0;

      if (gender == Gender.men) {
        newMenCount = (newMenCount + increment)
            .clamp(0, double.infinity)
            .toInt();
        print('🔍 updateCounter: Nuevo count hombres = $newMenCount');
      } else {
        newWomenCount = (newWomenCount + increment)
            .clamp(0, double.infinity)
            .toInt();
        print('🔍 updateCounter: Nuevo count mujeres = $newWomenCount');
      }

      // Paso 3: Guardar en BD
      print('🔍 updateCounter: Insertando/actualizando en BD...');
      await _database.insertOrUpdateCounter(
        date: dateOnly,
        category: category,
        menCount: newMenCount,
        womenCount: newWomenCount,
      );

      print('✅ updateCounter: Completado exitosamente');
    } catch (e) {
      print('❌ updateCounter: Error = $e');
      print('❌ updateCounter: Stack trace = ${StackTrace.current}');
      rethrow;
    }
  }

  Future<int> getTotalForToday() async {
    print('🔍 getTotalForToday: Iniciando...');
    try {
      final today = DateTime.now();
      final total = await _database.getTotalForDate(today);
      print('✅ getTotalForToday: Total = $total');
      return total;
    } catch (e) {
      print('❌ getTotalForToday: Error = $e');
      return 0; // Fallback seguro
    }
  }

  Future<bool> hasDataForToday() async {
    print('🔍 hasDataForToday: Iniciando...');
    try {
      final today = DateTime.now();
      final counters = await _database.getCountersForDate(today);
      final hasData = counters.isNotEmpty;
      print('✅ hasDataForToday: Resultado = $hasData');
      return hasData;
    } catch (e) {
      print('❌ hasDataForToday: Error = $e');
      return false; // Fallback seguro
    }
  }

  Future<DateTime?> getLastRegisteredDate() async {
    print('🔍 getLastRegisteredDate: Iniciando...');
    try {
      final lastDate = await _database.getLastRegisteredDate();
      print('✅ getLastRegisteredDate: Resultado = $lastDate');
      return lastDate;
    } catch (e) {
      print('❌ getLastRegisteredDate: Error = $e');
      return null; // Fallback seguro
    }
  }
}
