import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/rates_bloc.dart';
import '../../bloc/rates_event.dart';

/// Widget for date selection.
class DateSlider extends StatefulWidget {
  final List<DateTime> _dates;
  final DateTime _startAt;
  final DateTime _endAt;

  /// Requires list of [dates] available to selected and
  /// currently selected points [startAt], [endAt].
  const DateSlider({
    Key key,
    @required List<DateTime> dates,
    @required DateTime startAt,
    @required DateTime endAt,
  })  : assert(null != dates),
        assert(null != startAt),
        assert(null != endAt),
        _dates = dates,
        _startAt = startAt,
        _endAt = endAt,
        super(key: key);

  @override
  _DateSliderState createState() => _DateSliderState();
}

class _DateSliderState extends State<DateSlider> {
  static final _dateFormat = DateFormat("yyyy-MM-dd");

  RangeValues _values;

  @override
  Widget build(BuildContext context) {
    if (null == _values) {
      _createDefaultValues();
    }

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.blue[700],
        inactiveTrackColor: Colors.blue[100],
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        thumbColor: Colors.blueAccent,
        overlayColor: Colors.blue.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.blue[700],
        inactiveTickMarkColor: Colors.blue[100],
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.blueAccent,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: RangeSlider(
        values: _values,
        min: 0,
        max: widget._dates.length.toDouble() - 1,
        divisions: widget._dates.length - 1,
        labels: RangeLabels(
          _getDateAtIndexFormatted(_values.start),
          _getDateAtIndexFormatted(_values.end),
        ),
        onChanged: (values) {
          setState(
            () {
              final startAt = widget._dates[values.start.toInt()];
              final endAt = widget._dates[values.end.toInt()];

              BlocProvider.of<RatesBloc>(context)
                  .add(DateChanged(startAt: startAt, endAt: endAt));

              _values = values;
            },
          );
        },
      ),
    );
  }

  void _createDefaultValues() {
    final startIndex = widget._dates.indexOf(widget._startAt).toDouble();
    final endIndex = widget._dates.indexOf(widget._endAt).toDouble();
    _values = RangeValues(startIndex, endIndex);
  }

  String _getDateAtIndexFormatted(double index) {
    try {
      return _dateFormat.format(widget._dates[index.toInt()]);
    } on Exception catch (_) {
      return '???';
    }
  }
}
