import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../model/currency.dart';
import '../model/rates.dart';
import '../repository/rates_repository.dart';
import 'rates_event.dart';
import 'rates_state.dart';

/// Bloc for Rates.
class RatesBloc extends Bloc<RatesEvent, RatesState> {
  final RatesRepository _repository;

  DateTime _startAt = _defaultStartAt();
  DateTime _endAt = _defaultEndAt();
  String _baseCurrency = 'EUR';
  String _relativeCurrency = 'PLN';
  Rates _rates;

  final List<Currency> _currencies = Currency.currencies;
  final List<DateTime> _dates = RatesBloc._buildDates();

  /// Requires [repository].
  RatesBloc({@required RatesRepository repository})
      : assert(null != repository),
        _repository = repository;

  @override
  RatesState get initialState => RatesLoading();

  @override
  Stream<Transition<RatesEvent, RatesState>> transformEvents(
    Stream<RatesEvent> events,
    TransitionFunction<RatesEvent, RatesState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) => event is! DateChanged);
    final debounceStream = events
        .where((event) => event is DateChanged)
        .debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(
        MergeStream([nonDebounceStream, debounceStream]), transitionFn);
  }

  @override
  Stream<RatesState> mapEventToState(RatesEvent event) async* {
    print('event: $event');

    if (event is RatesReload) {
      yield* _fetchRates();
    } else if (event is CurrencySwap) {
      final baseCurrency = _baseCurrency;
      _baseCurrency = _relativeCurrency;
      _relativeCurrency = baseCurrency;
      yield* _fetchRates();
    } else if (event is RelativeCountryChanged) {
      _relativeCurrency = event.newCurrencyCode;
      yield* _fetchRates();
    } else if (event is BaseCountryChange) {
      _baseCurrency = event.newCurrencyCode;
      yield* _fetchRates();
    } else if (event is DateChanged) {
      _startAt = event.startAt;
      _endAt = event.endAt;
      yield* _fetchRates();
    }
  }

  Stream<RatesState> _fetchRates() async* {
    _rates = await _repository.getRates(
        _startAt, _endAt, _baseCurrency, _relativeCurrency);

    yield RatesLoaded(
      baseCurrencyCode: _baseCurrency,
      relativeCurrencyCode: _relativeCurrency,
      startAt: _startAt,
      endAt: _endAt,
      ratesData: _rates,
      currencies: _currencies,
      dates: _dates,
    );
  }

  static final Duration _defaultStartInterval = Duration(days: 120);

  static DateTime _defaultStartAt() {
    return _defaultEndAt().subtract(_defaultStartInterval);
  }

  static DateTime _defaultEndAt() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static List<DateTime> _buildDates() {
    final now = DateTime.now();
    final nowBase = DateTime(now.year, now.month, now.day);

    return List.generate(
      _defaultStartInterval.inDays + 1096,
      (index) => nowBase.subtract(Duration(days: index)),
    ).reversed.toList();
  }
}
