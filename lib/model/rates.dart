import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'rate.dart';

/// Represents rates - collection of [Rate].
/// This entity comes from http response.
class Rates extends Equatable {
  /// Start date for time period.
  final DateTime startAt;

  /// End date for time period.
  final DateTime endAt;

  /// Base currency code.
  final String base;

  /// Results.
  final List<Rate> rates;

  /// Requires time period defined as [startAt] and [endAt].
  /// Base currency [base] and list of [rates].
  const Rates({
    @required this.startAt,
    @required this.endAt,
    @required this.base,
    @required this.rates,
  })  : assert(null != startAt),
        assert(null != endAt),
        assert(null != base),
        assert(null != rates);

  /// Creates [Rates] from [json].
  static Rates fromJson(dynamic json) {
    final startAt = DateTime.parse(json['start_at'] as String);
    final endAt = DateTime.parse(json['end_at'] as String);
    final base = json['base'] as String;
    final rates = Rate.fromJson(json['rates']);

    return Rates(startAt: startAt, endAt: endAt, base: base, rates: rates);
  }

  @override
  List<Object> get props => [startAt, endAt, base, rates];

  @override
  String toString() =>
      'Rates(startAt=$startAt, endAt=$endAt, base=$base, rates=$rates)';
}
