import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Represents currency.
class Currency extends Equatable {
  /// Currency code in ISO-4217. Eg. 'PLN'.
  final String currencyCode;

  /// Country code in ISO-3166-1. Eg. 'pl'.
  final String countryCode;

  /// Requires [currencyCode] as ISO-4217
  /// and [countryCode] as ISO-3166-1 alpha 2-code.
  const Currency({@required this.currencyCode, @required this.countryCode})
      : assert(null != currencyCode),
        assert(null != countryCode);

  @override
  List<Object> get props => [currencyCode, countryCode];

  @override
  String toString() =>
      'Currency(currencyCode=$currencyCode, countryCode=$countryCode)';

  /// List of assailable currencies.
  static final List<Currency> currencies = [
    Currency(countryCode: 'pl', currencyCode: 'PLN'),
    Currency(countryCode: 'de', currencyCode: 'EUR'),
    Currency(countryCode: 'ca', currencyCode: 'CAD'),
    Currency(countryCode: 'hk', currencyCode: 'HKD'),
    Currency(countryCode: 'us', currencyCode: 'USD'),
    Currency(countryCode: 'no', currencyCode: 'NOK'),
    Currency(countryCode: 'se', currencyCode: 'SEK'),
    Currency(countryCode: 'cz', currencyCode: 'CZK'),
    Currency(countryCode: 'gb', currencyCode: 'GBP'),
    Currency(countryCode: 'ch', currencyCode: 'CHF'),
    Currency(countryCode: 'ru', currencyCode: 'RUB'),
  ];
}
