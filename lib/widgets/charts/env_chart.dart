import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ENVChart extends StatefulWidget {
  final List<dynamic> closes;
  final List<dynamic> upper;
  final List<dynamic> lower;
  final int graphPeriod;

  ENVChart(this.closes, this.upper, this.lower, this.graphPeriod);

  @override
  _ENVChartState createState() => _ENVChartState();
}

class _ENVChartState extends State<ENVChart> {
  List<dynamic> _closes;
  List<dynamic> _upper;
  List<dynamic> _lower;
  int _scope = 21;
  double _rate = 2.5;

  void calculateNewUpperLower() {
    var historicData =
        widget.closes.sublist(widget.closes.length - (90 + _scope - 1));
    var envValues = {"upper": [], "lower": []};

    for (var i = 0; i < 90; i++) {
      var envData = historicData.sublist(i, i + _scope);

      var dataAvg = envData.reduce((a, b) => a + b) / envData.length;
      var upper = dataAvg + dataAvg * _rate / 100;
      var lower = dataAvg - dataAvg * _rate / 100;

      envValues['upper'].add(upper);
      envValues['lower'].add(lower);
    }

    setState(() {
      _upper = envValues['upper'];
      _lower = envValues['lower'];
    });
  }

  @override
  void didChangeDependencies() {
    _closes = widget.closes;
    _upper = widget.upper;
    _lower = widget.lower;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, int>> series = [
      charts.Series(
        id: "ENV",
        data: _closes.sublist(widget.closes.length - widget.graphPeriod),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(134, 65, 244, 1)),
      ),
      charts.Series(
        id: "Dummy1",
        data: _upper.sublist(90 - widget.graphPeriod),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            Theme.of(context).colorScheme.onSecondary),
      ),
      charts.Series(
        id: "Dummy2",
        data: _lower.sublist(90 - widget.graphPeriod, 90),
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            Theme.of(context).colorScheme.onSecondary),
      ),
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Env Index',
            style: TextStyle(fontSize: 20),
          ),
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
                    desiredTickCount: 10),
                renderSpec: charts.GridlineRendererSpec(
                  labelOffsetFromAxisPx: 15,
                  labelStyle: charts.TextStyleSpec(
                      fontSize: 12, // size in Pts.
                      color: charts.ColorUtil.fromDartColor(Colors.grey[300])),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                        Color.fromRGBO(194, 79, 61, 0.4)),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Scope: $_scope',
                style: TextStyle(fontSize: 15),
              ),
              Expanded(
                child: Slider(
                  value: _scope.toDouble(),
                  min: 5,
                  max: 30,
                  divisions: 25,
                  label: '$_scope',
                  onChanged: (double newValue) {
                    setState(() {
                      _scope = newValue.round();
                      calculateNewUpperLower();
                    });
                  },
                ),
              ),
              Text(
                'Rate: $_rate',
                style: TextStyle(fontSize: 15),
              ),
              Expanded(
                child: Slider(
                  value: _rate.toDouble(),
                  min: 0,
                  max: 10,
                  divisions: 100,
                  label: '$_rate',
                  onChanged: (double newValue) {
                    setState(() {
                      _rate = double.parse(newValue.toStringAsFixed(1));
                      calculateNewUpperLower();
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
