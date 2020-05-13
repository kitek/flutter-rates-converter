import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/rates.dart';

/// HTTP Client.
class RatesApiClient {
  final http.Client _httpClient;
  final _dateFormat = DateFormat("yyyy-MM-dd");
  static const _baseUrl = 'https://api.exchangeratesapi.io';

  /// Requires [httpClient].
  RatesApiClient({@required http.Client httpClient})
      : assert(null != httpClient),
        _httpClient = httpClient;

  /// Fetches rates from remote JSON API.
  /// Throws exception for non 200 responses.
  Future<Rates> getRates(
    DateTime startAt,
    DateTime endAt,
    String baseCurrency,
    String relativeCurrency,
  ) async {
    final ratesUrl = '$_baseUrl/history'
        '?start_at=${_dateFormat.format(startAt)}'
        '&end_at=${_dateFormat.format(endAt)}'
        '&base=$baseCurrency'
        '&symbols=$relativeCurrency';

    final ratesResponse = await _httpClient.get(ratesUrl);
    if (ratesResponse.statusCode != 200) {
      throw Exception('Error getting rates.');
    }
    final body = utf8.decode(ratesResponse.bodyBytes);
    return Rates.fromJson(json.decode(body));
  }
}
