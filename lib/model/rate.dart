import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Represents single rate [value] for specific [date] and [currencyCode].
class Rate extends Equatable {
  /// Date from come results.
  final DateTime date;

  /// Currency for [value].
  final String currencyCode;

  /// Single rate value.
  final double value;

  /// Requires [date] from come results, [currencyCode] and [value].
  const Rate({
    @required this.date,
    @required this.currencyCode,
    @required this.value,
  })  : assert(null != date),
        assert(null != currencyCode),
        assert(null != value);

  /// Creates rate from JSON map.
  static List<Rate> fromJson(dynamic json) {
    final items = json as Map<String, dynamic>;

    return items.entries.expand((entry) {
      final date = DateTime.parse(entry.key);
      final items = entry.value as Map<String, dynamic>;
      return items.entries.map((item) {
        return Rate(date: date, currencyCode: item.key, value: item.value);
      }).toList();
    }).toList();
  }

  @override
  List<Object> get props => [date, currencyCode, value];

  @override
  String toString() => 'Rate(date=$date, currency=$currencyCode, value=$value)';
}
