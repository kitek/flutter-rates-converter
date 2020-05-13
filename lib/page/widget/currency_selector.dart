import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/rates_bloc.dart';
import '../../bloc/rates_event.dart';
import '../../model/currency.dart';

typedef DialogCallback = void Function(BuildContext context, String value);

/// Widget with buttons: base, swap, relative currency.
class CurrencySelector extends StatelessWidget {
  final String _baseCurrency;
  final String _relativeCurrency;
  final List<Currency> _currencies;

  /// Requires currently selected: [baseCurrency], [relativeCurrency]
  /// and list of all available [currencies].
  const CurrencySelector({
    Key key,
    @required String baseCurrency,
    @required String relativeCurrency,
    @required List<Currency> currencies,
  })  : assert(null != baseCurrency),
        assert(null != relativeCurrency),
        assert(null != currencies),
        _baseCurrency = baseCurrency,
        _relativeCurrency = relativeCurrency,
        _currencies = currencies,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text(_baseCurrency),
          onPressed: () {
            _showDialog(
              context,
              (context, value) => BlocProvider.of<RatesBloc>(context)
                  .add(BaseCountryChange(newCurrencyCode: value)),
            );
          },
        ),
        const SizedBox(width: 8.0),
        InkWell(
          child: const Icon(Icons.swap_horiz),
          onTap: () {
            BlocProvider.of<RatesBloc>(context).add(CurrencySwap());
          },
        ),
        const SizedBox(width: 8.0),
        RaisedButton(
          child: Text(_relativeCurrency),
          onPressed: () {
            _showDialog(
              context,
              (context, value) => BlocProvider.of<RatesBloc>(context)
                  .add(RelativeCountryChanged(newCurrencyCode: value)),
            );
          },
        ),
      ],
    );
  }

  Future<dynamic> _showDialog(BuildContext context, DialogCallback callback) {
    return showDialog(
      context: context,
      builder: (newContext) => SimpleDialog(
        title: const Text('Select currency'),
        children: _currencies
            .map(
              (currency) => SimpleDialogOption(
                child: Row(
                  children: [
                    SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: Image.asset(
                        'icons/flags/png/${currency.countryCode}.png',
                        package: 'country_icons',
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(currency.currencyCode),
                  ],
                ),
                onPressed: () {
                  callback(context, currency.currencyCode);
                  Navigator.pop(newContext);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
