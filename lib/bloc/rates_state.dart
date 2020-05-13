import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../model/currency.dart';
import '../model/rates.dart';

/// Generic class for states.
abstract class RatesState extends Equatable {
  ///
  const RatesState();

  @override
  List<Object> get props => [];
}

/// State for loading.
class RatesLoading extends RatesState {
  ///
  const RatesLoading();
}

/// Represents state for loaded data.
class RatesLoaded extends RatesState {
  /// Base currency code.
  final String baseCurrencyCode;

  /// Relative currency code.
  final String relativeCurrencyCode;

  /// Start date for time period.
  final DateTime startAt;

  /// End date for time period.
  final DateTime endAt;

  /// Results for chart.
  final Rates ratesData;

  /// List of available currencies for currency selector.
  final List<Currency> currencies;

  /// List of dates for date slider.
  final List<DateTime> dates;

  /// Requires currencies: [baseCurrencyCode] and [relativeCurrencyCode],
  /// time period: [startAt] and [endAt],
  /// results for chart [ratesData],
  /// list of available [currencies] for currency selector,
  /// list of [dates] for date slider.
  const RatesLoaded({
    @required this.baseCurrencyCode,
    @required this.relativeCurrencyCode,
    @required this.startAt,
    @required this.endAt,
    @required this.ratesData,
    @required this.currencies,
    @required this.dates,
  });

  @override
  String toString() => 'RatesLoaded('
      'baseCurrency=$baseCurrencyCode, '
      'relativeCurrency=$relativeCurrencyCode,'
      'startAt=$startAt,'
      'endAt=$endAt,'
      'ratesData=$ratesData,'
      ')';

  @override
  List<Object> get props => [
        baseCurrencyCode,
        relativeCurrencyCode,
        startAt,
        endAt,
        ratesData,
        currencies,
        dates,
      ];
}
