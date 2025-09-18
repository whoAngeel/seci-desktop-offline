import 'package:seci_desktop/core/constants.dart';
import 'package:seci_desktop/core/database/database.dart';
import 'package:seci_desktop/features/counters/domain/entities/counter_entity.dart';

class CounterRepo {
  final AppDatabase _database;

  CounterRepo(this._database);

  Future<List<CounterEntity>> getCountersForToday() async {
    final today = DateTime.now();
    final dbCounters = await _database.getCountersForDate(today);

    final counters = <CounterEntity>[];

    // crear lista completa con todas las categorias
    for (final category in Categories.all) {
      final dbCounter = dbCounters
          .where((element) => element.category == category)
          .firstOrNull;
      counters.add(
        CounterEntity(
          category: category,
          menCount: dbCounter?.menCount ?? 0,
          womenCount: dbCounter?.womenCount ?? 0,
          date: DateTime(today.year, today.month, today.day),
        ),
      );
    }
    return counters;
  }

  Future<void> updateCounter({
    required String category,
    required Gender gender,
    required int increment,
  }) async {
    final today = DateTime.now();
    final dateOnly = DateTime(today.year, today.month, today.day);

    // contadores actuales
    final currentCounters = await _database.getCountersForDate(dateOnly);
    final currentCounter = currentCounters
        .where((element) => element.category == category)
        .firstOrNull;

    int newMenCount = currentCounter?.menCount ?? 0;
    int newWomenCount = currentCounter?.womenCount ?? 0;

    if (gender == Gender.men) {
      newMenCount = (newMenCount + increment).clamp(0, double.infinity).toInt();
    } else {
      newWomenCount = (newWomenCount + increment)
          .clamp(0, double.infinity)
          .toInt();
    }

    await _database.insertOrUpdateCounter(
      date: dateOnly,
      category: category,
      menCount: newMenCount,
      womenCount: newWomenCount,
    );
  }

  Future<int> getTotalForToday() async {
    final today = DateTime.now();
    return await _database.getTotalForDate(today);
  }

  Future<bool> hasDataForToday() async {
    final today = DateTime.now();
    final counters = await _database.getCountersForDate(today);
    return counters.isNotEmpty;
  }

  Future<DateTime?> getLastRegisteredDate() async {
    return await _database.getLastRegisteredDate();
  }
}
