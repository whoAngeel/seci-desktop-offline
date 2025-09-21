// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(database)
const databaseProvider = DatabaseProvider._();

final class DatabaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppDatabase>,
          AppDatabase,
          FutureOr<AppDatabase>
        >
    with $FutureModifier<AppDatabase>, $FutureProvider<AppDatabase> {
  const DatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseHash();

  @$internal
  @override
  $FutureProviderElement<AppDatabase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppDatabase> create(Ref ref) {
    return database(ref);
  }
}

String _$databaseHash() => r'49ef699ba073e227c7bb93fc5dbfdaf513599130';

@ProviderFor(counterRepository)
const counterRepositoryProvider = CounterRepositoryProvider._();

final class CounterRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<CounterRepo>,
          CounterRepo,
          FutureOr<CounterRepo>
        >
    with $FutureModifier<CounterRepo>, $FutureProvider<CounterRepo> {
  const CounterRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'counterRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$counterRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<CounterRepo> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CounterRepo> create(Ref ref) {
    return counterRepository(ref);
  }
}

String _$counterRepositoryHash() => r'c38a6735fb1438ef13b1b6bfc38907a330ece77a';

@ProviderFor(Counter)
const counterProvider = CounterProvider._();

final class CounterProvider extends $NotifierProvider<Counter, CounterState> {
  const CounterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'counterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$counterHash();

  @$internal
  @override
  Counter create() => Counter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CounterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CounterState>(value),
    );
  }
}

String _$counterHash() => r'ce21e7b7997fc80f98160c97e1f7f774791fddbc';

abstract class _$Counter extends $Notifier<CounterState> {
  CounterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CounterState, CounterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CounterState, CounterState>,
              CounterState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
