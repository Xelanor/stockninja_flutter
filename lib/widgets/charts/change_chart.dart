import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChangeChart extends StatefulWidget {
  final List<dynamic> events;

  ChangeChart(this.events);

  @override
  _ChangeChartState createState() => _ChangeChartState();
}

class _ChangeChartState extends State<ChangeChart> {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  var _increasing = [];
  var _decreasing = [];
  var _bist = [];

  @override
  void didChangeDependencies() {
    var _events = widget.events.reversed.toList().sublist(36, 66);
    for (var i = 0; i < _events.length; i++) {
      _increasing.add(_events[i]['increasing']);
      _decreasing.add(_events[i]['decreasing']);
      _bist.add(_events[i]['bist'] / 1000);
    }
    setState(() {
      _increasing = _increasing;
      _decreasing = _decreasing;
      _bist = _bist;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, int>> series = [
      charts.Series(
        id: "Increasing",
        data: _increasing,
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(124, 252, 0, 0.5)),
      ),
      charts.Series(
        id: "Decreasing",
        data: _decreasing,
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(255, 64, 64, 0.5)),
      ),
      charts.Series(
        id: "Bist",
        data: _bist,
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(134, 65, 244, 1)),
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];

    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Expanded(
            child: charts.LineChart(
              series,
              animate: true,
              domainAxis: charts.NumericAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                      fontSize: 12, // size in Pts.
                      color: charts.ColorUtil.fromDartColor(Colors.grey[400])),
                  lineStyle: charts.LineStyleSpec(
                      color: charts.ColorUtil.fromDartColor(Colors.grey)),
                ),
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                  dataIsInWholeNumbers: false,
                  zeroBound: false,
                  desiredTickCount: 5,
                ),
                renderSpec: charts.GridlineRendererSpec(
                  labelOffsetFromAxisPx: 15,
                  labelStyle: charts.TextStyleSpec(
                      fontSize: 12, // size in Pts.
                      color: charts.ColorUtil.fromDartColor(Colors.grey[300])),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                        Color.fromRGBO(0, 79, 61, 0.4)),
                  ),
                ),
              ),
              secondaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                  dataIsInWholeNumbers: false,
                  zeroBound: false,
                  desiredTickCount: 5,
                ),
                renderSpec: charts.GridlineRendererSpec(
                  labelOffsetFromAxisPx: 15,
                  labelStyle: charts.TextStyleSpec(
                      fontSize: 12, // size in Pts.
                      color: charts.ColorUtil.fromDartColor(Colors.grey[300])),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                        Color.fromRGBO(0, 79, 61, 0.4)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
