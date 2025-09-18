class CounterEntity {
  final String category;
  final int menCount;
  final int womenCount;
  final DateTime date;

  const CounterEntity({
    required this.category,
    required this.menCount,
    required this.womenCount,
    required this.date,
  });

  int get total => menCount + womenCount;

  CounterEntity copyWith({
    String? category,
    int? menCount,
    int? womenCount,
    DateTime? date,
  }) {
    return CounterEntity(
      category: category ?? this.category,
      menCount: menCount ?? this.menCount,
      womenCount: womenCount ?? this.womenCount,
      date: date ?? this.date,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CounterEntity &&
        other.category == category &&
        other.menCount == menCount &&
        other.womenCount == womenCount &&
        other.date == date;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        menCount.hashCode ^
        womenCount.hashCode ^
        date.hashCode;
  }

  @override
  String toString() {
    return 'CounterEntity(category: $category, men: $menCount, women: $womenCount, total: $total, date: $date)';
  }
}
