import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Generic class for all events.
abstract class RatesEvent extends Equatable {
  ///
  const RatesEvent();

  @override
  List<Object> get props => [];
}

/// Reloads current rates.
class RatesReload extends RatesEvent {
  ///
  const RatesReload();
}

/// Changes selected dates range.
class DateChanged extends RatesEvent {
  /// Date start.
  final DateTime startAt;

  /// Date end.
  final DateTime endAt;

  /// Requires [startAt], [endAt].
  const DateChanged({@required this.startAt, @required this.endAt})
      : assert(null != startAt),
        assert(null != endAt);

  @override
  List<Object> get props => [startAt, endAt];

  @override
  String toString() => 'DateChanged(date=$startAt)';
}

/// Changes selected relative country.
class RelativeCountryChanged extends RatesEvent {
  /// Currency code for relative country.
  final String newCurrencyCode;

  /// Requires [newCurrencyCode].
  const RelativeCountryChanged({@required this.newCurrencyCode})
      : assert(null != newCurrencyCode);

  @override
  List<Object> get props => [newCurrencyCode];

  @override
  String toString() => 'RelativeCountryChanged(newCurrency=$newCurrencyCode)';
}

/// Changes selected base country.
class BaseCountryChange extends RatesEvent {
  /// Currency code for base country.
  final String newCurrencyCode;

  /// Requires [newCurrencyCode].
  const BaseCountryChange({@required this.newCurrencyCode})
      : assert(null != newCurrencyCode);

  @override
  List<Object> get props => [newCurrencyCode];

  @override
  String toString() => 'BaseCountryChange(newCurrency=$newCurrencyCode)';
}

/// Swap currencies.
class CurrencySwap extends RatesEvent {
  ///
  const CurrencySwap();
}
