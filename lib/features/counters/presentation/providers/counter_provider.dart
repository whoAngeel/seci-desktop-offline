import 'package:seci_desktop/core/constants.dart';
import 'package:seci_desktop/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seci_desktop/features/counters/data/repository/counter_repo.dart';
import 'package:seci_desktop/features/counters/domain/entities/counter_entity.dart';

part 'counter_provider.g.dart';

@riverpod
AppDatabase database(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}

@riverpod
CounterRepo counterRepository(Ref ref) {
  final database = ref.watch(databaseProvider);
  return CounterRepo(database);
}

// Estado de los contadores
class CounterState {
  final List<CounterEntity> counters;
  final int totalCount;
  final bool isLoading;
  final DateTime currentDate;
  final String? error;

  const CounterState({
    required this.counters,
    required this.totalCount,
    required this.isLoading,
    required this.currentDate,
    this.error,
  });

  CounterState copyWith({
    List<CounterEntity>? counters,
    int? totalCount,
    bool? isLoading,
    DateTime? currentDate,
    String? error,
  }) {
    return CounterState(
      counters: counters ?? this.counters,
      totalCount: totalCount ?? this.totalCount,
      isLoading: isLoading ?? this.isLoading,
      currentDate: currentDate ?? this.currentDate,
      error: error ?? this.error,
    );
  }
}

@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  CounterState build() {
    return CounterState(
      counters: [],
      totalCount: 0,
      isLoading: true,
      currentDate: DateTime.now(),
    );
  }

  Future<void> _initializerCounters() async {
    try {
      final repository = ref.read(counterRepositoryProvider);

      // await _checkDateConsistency();
    } catch (e) {
      state = state.copyWith(
        error: 'Error al cargar los contadores: $e',
        isLoading: false,
      );
    }
  }

  Future<void> incrementCounter(String category, Gender gender) async {
    await _updateCounter(category, gender, 1);
  }

  Future<void> decrementCounter(String category, Gender gender) async {
    await _updateCounter(category, gender, -1);
  }

  Future<void> _updateCounter(
    String category,
    Gender gender,
    int increment,
  ) async {
    try {
      final repository = ref.read(counterRepositoryProvider);

      // actualizar en base de datos
      await repository.updateCounter(
        category: category,
        gender: gender,
        increment: increment,
      );

      // actualiar estado local
      final updateCounters = state.counters.map((counter) {
        if (counter.category == category) {
          if (gender == Gender.men) {
            return counter.copyWith(
              menCount: (counter.menCount + increment)
                  .clamp(0, double.infinity)
                  .toInt(),
            );
          } else {
            return counter.copyWith(
              womenCount: (counter.womenCount + increment)
                  .clamp(0, double.infinity)
                  .toInt(),
            );
          }
        }
        return counter;
      }).toList();

      final newTotalCount = updateCounters.fold(
        0,
        (sum, counter) => sum + counter.total,
      );

      state = state.copyWith(
        counters: updateCounters,
        totalCount: newTotalCount,
      );
    } catch (e) {
      state = state.copyWith(error: 'Error al actualizar el contador: $e');
    }
  }

  Future<void> _checkDateConsistency() async {
    final repository = ref.read(counterRepositoryProvider);
    final lastDate = await repository.getLastRegisteredDate();
    final currentDate = DateTime.now();

    if (lastDate != null) {
      final lastDateOnly = DateTime(
        lastDate.year,
        lastDate.month,
        lastDate.day,
      );

      final currentDateOnly = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      );
      if (currentDateOnly.isBefore(lastDateOnly)) {
        // se podria emiitr un evento para mostrar un warning
        state = state.copyWith(
          error: 'La fecha del sistema parece haber retrocedido',
        );
      }
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
