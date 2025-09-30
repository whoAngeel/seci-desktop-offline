import 'package:flutter/material.dart';
import 'package:seci_desktop/core/constants.dart';
import 'package:seci_desktop/core/database/database.dart';
import 'package:seci_desktop/core/utils/date_utils.dart' as date_utils;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seci_desktop/features/counters/data/repository/counter_repo.dart';
import 'package:seci_desktop/features/counters/domain/entities/counter_entity.dart';
import 'dart:async';
part 'counter_provider.g.dart';

// Provider para la base de datos
@riverpod
Future<AppDatabase> database(Ref ref) async {
  print('📚 Provider: Inicializando base de datos...');
  final db = await AppDatabase.getInstance();
  // ref.onDispose(() => db.close());
  print('✅ Provider: Base de datos inicializada');
  return db;
}

// Provider para el repository
@riverpod
Future<CounterRepo> counterRepository(Ref ref) async {
  final database = await ref.watch(databaseProvider.future);
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
  Timer? _dayChangeTimer;
  @override
  CounterState build() {
    // Verificar cambio de dia al iniciar la app
    _checkForDayChangeOnInit();
    _initializeCounters();
    _startDayChangeDetection();

    // limpiar timer cuando se destruya el provider
    ref.onDispose(() {
      _dayChangeTimer?.cancel();
    });

    return CounterState(
      counters: _createEmptyCounters(),
      totalCount: 0,
      isLoading: true,
      currentDate: DateTime.now(),
    );
  }

  void _startDayChangeDetection() {
    _dayChangeTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkForDayChange();
    });
  }

  void _checkForDayChange() {
    final now = DateTime.now();
    final currentDate = date_utils.DateUtils.dateOnly(now);
    final stateDate = date_utils.DateUtils.dateOnly(state.currentDate);

    // Si la fecha cambió, recargar contadores
    if (!date_utils.DateUtils.isSameDay(currentDate, stateDate)) {
      print('');
      print('🔄 Counter: ═══════════════════════════════════════');
      print('🔄 Counter: CAMBIO DE DÍA DETECTADO');
      print(
        '📅 Counter: Fecha anterior: ${date_utils.DateUtils.formatDate(stateDate)}',
      );
      print(
        '📅 Counter: Fecha nueva: ${date_utils.DateUtils.formatDate(currentDate)}',
      );
      print('🔄 Counter: ═══════════════════════════════════════');
      print('');

      _initializeCounters();
    }
  }

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
      print('🔄 Counter: Esperando inicialización de BD...');

      print('🔄 Counter: BD lista, obteniendo repository...');
      final repository = await ref.read(counterRepositoryProvider.future);

      print('🔄 Counter: Cargando contadores...');
      final counters = await repository.getCountersForToday();
      final total = await repository.getTotalForToday();

      print('✅ Counter: Contadores cargados: ${counters.length}');
      state = state.copyWith(
        counters: counters,
        totalCount: total,
        isLoading: false,
        currentDate: DateTime.now(),
        error: null,
      );
    } catch (e) {
      print('❌ Counter: Error en inicialización: $e');
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
      print('🔄 Counter: Actualizando $category ${gender.name} +$increment');

      // Obtener repository
      final repository = await ref.read(counterRepositoryProvider.future);

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
        error: null,
      );

      print('✅ Counter: Actualización completada');
    } catch (e) {
      print('❌ Counter: Error actualizando: $e');
      state = state.copyWith(error: 'Error al actualizar contador: $e');
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await _initializeCounters();
  }

  Future<void> _checkForDayChangeOnInit() async {
    try {
      print('Counter: verificando cambio de dia al iniciar...');
      final repository = await ref.read(counterRepositoryProvider.future);
      final lastDate = await repository.getLastRegisteredDate();
      final today = date_utils.DateUtils.dateOnly(DateTime.now());

      if (lastDate == null) {
        print('Primera ejecucion, no hay fecha registrada');
        return;
      }
      final lastDateOnly = date_utils.DateUtils.dateOnly(lastDate);

      if (date_utils.DateUtils.isAfterDay(today, lastDateOnly)) {
        final daysPassed = date_utils.DateUtils.daysBetween(
          lastDateOnly,
          today,
        );
        print('🔄 Counter: Cambio de día detectado al iniciar');
        print(
          '📅 Counter: Última fecha: ${date_utils.DateUtils.formatDate(lastDateOnly)}',
        );
        print(
          '📅 Counter: Fecha actual: ${date_utils.DateUtils.formatDate(today)}',
        );
        print('📊 Counter: Días transcurridos: $daysPassed');
        print('✨ Counter: Iniciando nuevo día con contadores en 0');
      } else if (date_utils.DateUtils.isSameDay(today, lastDateOnly)) {
        print('Counter: misma fecha, no hacer nada');
      } else {
        // Caso edge: fecha del sistema retrocedió
        print('⚠️ Counter: ADVERTENCIA - La fecha del sistema retrocedió');
        print(
          '📅 Counter: Última fecha en BD: ${date_utils.DateUtils.formatDate(lastDateOnly)}',
        );
        print(
          '📅 Counter: Fecha del sistema: ${date_utils.DateUtils.formatDate(today)}',
        );
      }
    } catch (e) {
      print('❌ Counter: Error en checkForDayChangeOnInit: $e');
    }
  }
}
