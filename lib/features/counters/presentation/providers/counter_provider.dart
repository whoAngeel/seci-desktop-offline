import 'package:seci_desktop/core/constants.dart';
import 'package:seci_desktop/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seci_desktop/features/counters/data/repository/counter_repo.dart';
import 'package:seci_desktop/features/counters/domain/entities/counter_entity.dart';

part 'counter_provider.g.dart';

// Provider para la base de datos
@riverpod
AppDatabase database(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}

// Provider para el repository
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
class Counter extends _$Counter {
  @override
  CounterState build() {
    // ✅ MEJORADO: Inicialización inmediata con carga de datos por defecto
    _initializeCounters();

    // ✅ Retorna estado inicial con contadores vacíos pero válidos
    return CounterState(
      counters: _createEmptyCounters(),
      totalCount: 0,
      isLoading: true,
      currentDate: DateTime.now(),
    );
  }

  // ✅ Crear contadores vacíos por defecto para evitar lista vacía
  List<CounterEntity> _createEmptyCounters() {
    final today = DateTime.now();
    final dateOnly = DateTime(today.year, today.month, today.day);

    return Categories.all
        .map(
          (category) => CounterEntity(
            category: category,
            menCount: 0,
            womenCount: 0,
            date: dateOnly,
          ),
        )
        .toList();
  }

  Future<void> _initializeCounters() async {
    try {
      await Future.delayed(
        const Duration(milliseconds: 100),
      ); // Dar tiempo a la BD

      final repository = ref.read(counterRepositoryProvider);

      // Verificar consistencia de fecha
      await _checkDateConsistency();

      // Cargar contadores del día
      final counters = await repository.getCountersForToday();
      final total = await repository.getTotalForToday();

      state = state.copyWith(
        counters: counters,
        totalCount: total,
        isLoading: false,
        currentDate: DateTime.now(),
        error: null, // Limpiar errores previos
      );
    } catch (e) {
      // ✅ Mantener contadores vacíos funcionales en caso de error
      state = state.copyWith(
        counters: _createEmptyCounters(),
        isLoading: false,
        error: 'Error al cargar contadores: $e',
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

      // Actualizar en base de datos
      await repository.updateCounter(
        category: category,
        gender: gender,
        increment: increment,
      );

      // Actualizar estado local
      final updatedCounters = state.counters.map((counter) {
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

      final newTotal = updatedCounters.fold(
        0,
        (sum, counter) => sum + counter.total,
      );

      state = state.copyWith(
        counters: updatedCounters,
        totalCount: newTotal,
        error: null, // Limpiar errores en operación exitosa
      );
    } catch (e) {
      state = state.copyWith(error: 'Error al actualizar contador: $e');
    }
  }

  Future<void> _checkDateConsistency() async {
    try {
      final repository = ref.read(counterRepositoryProvider);

      // Solo verificar si ya hay datos en la BD
      final hasData = await repository.hasDataForToday();
      if (!hasData) {
        return; // No verificar fecha si no hay datos previos
      }

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
          state = state.copyWith(
            error: 'Advertencia: La fecha del sistema parece haber retrocedido',
          );
        }
      }
    } catch (e) {
      // No mostrar error de consistencia de fecha
      print('Warning: Error checking date consistency: $e');
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  // ✅ Método para refrescar datos manualmente
  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await _initializeCounters();
  }
}
