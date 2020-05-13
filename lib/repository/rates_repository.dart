import 'package:flutter/foundation.dart';

import '../model/rate.dart';
import '../model/rates.dart';
import 'rates_api_client.dart';

/// Provides access to currency rates.
class RatesRepository {
  final RatesApiClient _apiClient;

  /// Creates repo. Requires [apiClient].
  RatesRepository({@required RatesApiClient apiClient})
      : assert(null != apiClient),
        _apiClient = apiClient;

  /// Fetches rates for provided time range and currencies.
  Future<Rates> getRates(
    DateTime startAt,
    DateTime endAt,
    String baseCurrency,
    String relativeCurrency,
  ) async {
    assert(startAt.isBefore(endAt));

    final response = await _apiClient.getRates(
        startAt, endAt, baseCurrency, relativeCurrency);
    response.rates.sort(_sortRates);
    return response;
  }

  int _sortRates(Rate a, Rate b) => a.date.compareTo(b.date);
}
