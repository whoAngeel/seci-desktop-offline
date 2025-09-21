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
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
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
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return database(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$databaseHash() => r'b43f5a38382427710fbceefeb419518e859b35ea';

@ProviderFor(counterRepository)
const counterRepositoryProvider = CounterRepositoryProvider._();

final class CounterRepositoryProvider
    extends $FunctionalProvider<CounterRepo, CounterRepo, CounterRepo>
    with $Provider<CounterRepo> {
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
  $ProviderElement<CounterRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CounterRepo create(Ref ref) {
    return counterRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CounterRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CounterRepo>(value),
    );
  }
}

String _$counterRepositoryHash() => r'f564e9b8317bb5e6444d42de21b148667cb35580';

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

String _$counterHash() => r'eeecf7128fa9052de58d10d5847dae46c42d7151';

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
