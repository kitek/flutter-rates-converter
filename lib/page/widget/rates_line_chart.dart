import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// ignore: implementation_imports
import 'package:charts_flutter/src/text_element.dart' as charts_text;

// ignore: implementation_imports
import 'package:charts_flutter/src/text_style.dart' as charts_style;

import '../../model/rate.dart';

/// Widget for showing graph.
class RatesLineChart extends StatelessWidget {
  final List<Rate> _rates;

  static String _pointerValue;

  /// Requires list of [rates] to display.
  const RatesLineChart({Key key, @required List<Rate> rates})
      : assert(null != rates),
        _rates = rates,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      _createSeries(),
      behaviors: [
        LinePointHighlighter(symbolRenderer: _CustomCircleSymbolRenderer())
      ],
      selectionModels: [
        SelectionModelConfig(changedListener: (model) {
          if (model.hasDatumSelection) {
            _pointerValue = model.selectedSeries[0]
                .measureFn(model.selectedDatum[0].index)
                .toString();
          }
        }),
      ],
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 45,
        ),
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(
            format: 'yyyy-MM-dd',
            transitionFormat: 'yyyy-MM-dd',
          ),
        ),
      ),
    );
  }

  List<charts.Series<Rate, DateTime>> _createSeries() {
    return [
      charts.Series<Rate, DateTime>(
        id: 'Rates',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (rate, _) => rate.date,
        measureFn: (rate, _) => rate.value,
        data: _rates,
      ),
    ];
  }
}

class _CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      Color fillColor,
      FillPatternType fillPattern,
      Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);

    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
            bounds.height + 10),
        fill: Color.white);

    var textStyle = charts_style.TextStyle();
    textStyle.color = Color.black;
    textStyle.fontSize = 15;

    canvas.drawText(
        charts_text.TextElement(RatesLineChart._pointerValue, style: textStyle),
        (bounds.left).round(),
        (bounds.top - 28).round());
  }
}
