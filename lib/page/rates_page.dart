import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/rates_bloc.dart';
import '../bloc/rates_event.dart';
import '../bloc/rates_state.dart';
import 'widget/currency_selector.dart';
import 'widget/date_slider.dart';
import 'widget/rates_line_chart.dart';

/// Page with charts, slider and buttons.
class RatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rates converter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () =>
                BlocProvider.of<RatesBloc>(context).add(RatesReload()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<RatesBloc, RatesState>(builder: (context, state) {
          if (state is RatesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RatesLoaded) {
            return Column(
              children: <Widget>[
                Expanded(child: RatesLineChart(rates: state.ratesData.rates)),
                DateSlider(
                  dates: state.dates,
                  startAt: state.startAt,
                  endAt: state.endAt,
                ),
                CurrencySelector(
                  baseCurrency: state.baseCurrencyCode,
                  relativeCurrency: state.relativeCurrencyCode,
                  currencies: state.currencies,
                ),
              ],
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
