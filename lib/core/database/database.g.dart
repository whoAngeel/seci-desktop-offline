// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DailyCountsTable extends DailyCounts
    with TableInfo<$DailyCountsTable, DailyCount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyCountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _menCountMeta = const VerificationMeta(
    'menCount',
  );
  @override
  late final GeneratedColumn<int> menCount = GeneratedColumn<int>(
    'men_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _womenCountMeta = const VerificationMeta(
    'womenCount',
  );
  @override
  late final GeneratedColumn<int> womenCount = GeneratedColumn<int>(
    'women_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    category,
    menCount,
    womenCount,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_counts';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyCount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('men_count')) {
      context.handle(
        _menCountMeta,
        menCount.isAcceptableOrUnknown(data['men_count']!, _menCountMeta),
      );
    }
    if (data.containsKey('women_count')) {
      context.handle(
        _womenCountMeta,
        womenCount.isAcceptableOrUnknown(data['women_count']!, _womenCountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {date, category},
  ];
  @override
  DailyCount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyCount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      menCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}men_count'],
      )!,
      womenCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}women_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DailyCountsTable createAlias(String alias) {
    return $DailyCountsTable(attachedDatabase, alias);
  }
}

class DailyCount extends DataClass implements Insertable<DailyCount> {
  final int id;
  final DateTime date;
  final String category;
  final int menCount;
  final int womenCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DailyCount({
    required this.id,
    required this.date,
    required this.category,
    required this.menCount,
    required this.womenCount,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['category'] = Variable<String>(category);
    map['men_count'] = Variable<int>(menCount);
    map['women_count'] = Variable<int>(womenCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyCountsCompanion toCompanion(bool nullToAbsent) {
    return DailyCountsCompanion(
      id: Value(id),
      date: Value(date),
      category: Value(category),
      menCount: Value(menCount),
      womenCount: Value(womenCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyCount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyCount(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      category: serializer.fromJson<String>(json['category']),
      menCount: serializer.fromJson<int>(json['menCount']),
      womenCount: serializer.fromJson<int>(json['womenCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'category': serializer.toJson<String>(category),
      'menCount': serializer.toJson<int>(menCount),
      'womenCount': serializer.toJson<int>(womenCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyCount copyWith({
    int? id,
    DateTime? date,
    String? category,
    int? menCount,
    int? womenCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DailyCount(
    id: id ?? this.id,
    date: date ?? this.date,
    category: category ?? this.category,
    menCount: menCount ?? this.menCount,
    womenCount: womenCount ?? this.womenCount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DailyCount copyWithCompanion(DailyCountsCompanion data) {
    return DailyCount(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      category: data.category.present ? data.category.value : this.category,
      menCount: data.menCount.present ? data.menCount.value : this.menCount,
      womenCount: data.womenCount.present
          ? data.womenCount.value
          : this.womenCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyCount(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('menCount: $menCount, ')
          ..write('womenCount: $womenCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    category,
    menCount,
    womenCount,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyCount &&
          other.id == this.id &&
          other.date == this.date &&
          other.category == this.category &&
          other.menCount == this.menCount &&
          other.womenCount == this.womenCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyCountsCompanion extends UpdateCompanion<DailyCount> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> category;
  final Value<int> menCount;
  final Value<int> womenCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const DailyCountsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.menCount = const Value.absent(),
    this.womenCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DailyCountsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String category,
    this.menCount = const Value.absent(),
    this.womenCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : date = Value(date),
       category = Value(category);
  static Insertable<DailyCount> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? category,
    Expression<int>? menCount,
    Expression<int>? womenCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (menCount != null) 'men_count': menCount,
      if (womenCount != null) 'women_count': womenCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DailyCountsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? category,
    Value<int>? menCount,
    Value<int>? womenCount,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return DailyCountsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      category: category ?? this.category,
      menCount: menCount ?? this.menCount,
      womenCount: womenCount ?? this.womenCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (menCount.present) {
      map['men_count'] = Variable<int>(menCount.value);
    }
    if (womenCount.present) {
      map['women_count'] = Variable<int>(womenCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyCountsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('menCount: $menCount, ')
          ..write('womenCount: $womenCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DailyCountsTable dailyCounts = $DailyCountsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dailyCounts];
}

typedef $$DailyCountsTableCreateCompanionBuilder =
    DailyCountsCompanion Function({
      Value<int> id,
      required DateTime date,
      required String category,
      Value<int> menCount,
      Value<int> womenCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$DailyCountsTableUpdateCompanionBuilder =
    DailyCountsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> category,
      Value<int> menCount,
      Value<int> womenCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$DailyCountsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyCountsTable> {
  $$DailyCountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get menCount => $composableBuilder(
    column: $table.menCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get womenCount => $composableBuilder(
    column: $table.womenCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyCountsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyCountsTable> {
  $$DailyCountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get menCount => $composableBuilder(
    column: $table.menCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get womenCount => $composableBuilder(
    column: $table.womenCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyCountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyCountsTable> {
  $$DailyCountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get menCount =>
      $composableBuilder(column: $table.menCount, builder: (column) => column);

  GeneratedColumn<int> get womenCount => $composableBuilder(
    column: $table.womenCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyCountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyCountsTable,
          DailyCount,
          $$DailyCountsTableFilterComposer,
          $$DailyCountsTableOrderingComposer,
          $$DailyCountsTableAnnotationComposer,
          $$DailyCountsTableCreateCompanionBuilder,
          $$DailyCountsTableUpdateCompanionBuilder,
          (
            DailyCount,
            BaseReferences<_$AppDatabase, $DailyCountsTable, DailyCount>,
          ),
          DailyCount,
          PrefetchHooks Function()
        > {
  $$DailyCountsTableTableManager(_$AppDatabase db, $DailyCountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyCountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyCountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyCountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> menCount = const Value.absent(),
                Value<int> womenCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DailyCountsCompanion(
                id: id,
                date: date,
                category: category,
                menCount: menCount,
                womenCount: womenCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String category,
                Value<int> menCount = const Value.absent(),
                Value<int> womenCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DailyCountsCompanion.insert(
                id: id,
                date: date,
                category: category,
                menCount: menCount,
                womenCount: womenCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyCountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyCountsTable,
      DailyCount,
      $$DailyCountsTableFilterComposer,
      $$DailyCountsTableOrderingComposer,
      $$DailyCountsTableAnnotationComposer,
      $$DailyCountsTableCreateCompanionBuilder,
      $$DailyCountsTableUpdateCompanionBuilder,
      (
        DailyCount,
        BaseReferences<_$AppDatabase, $DailyCountsTable, DailyCount>,
      ),
      DailyCount,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DailyCountsTableTableManager get dailyCounts =>
      $$DailyCountsTableTableManager(_db, _db.dailyCounts);
}
