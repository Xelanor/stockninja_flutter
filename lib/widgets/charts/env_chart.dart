import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ENVChart extends StatefulWidget {
  final List<dynamic> closes;
  final List<dynamic> upper;
  final List<dynamic> lower;

  ENVChart(this.closes, this.upper, this.lower);

  @override
  _ENVChartState createState() => _ENVChartState();
}

class _ENVChartState extends State<ENVChart> {
  var _isInit = true;
  var _duration = 1;
  var _allCloses;
  var _allUpper;
  var _allLower;
  var _closes;
  var _upper;
  var _lower;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _allCloses = widget.closes;
      _allUpper = widget.upper;
      _allLower = widget.lower;
      _closes = widget.closes.sublist(60, 90);
      _upper = widget.upper.sublist(60, 90);
      _lower = widget.lower.sublist(60, 90);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, int>> series = [
      charts.Series(
        id: "ENV",
        data: _closes,
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(134, 65, 244, 1)),
      ),
      charts.Series(
        id: "Dummy1",
        data: _upper,
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            Theme.of(context).colorScheme.onSecondary),
      ),
      charts.Series(
        id: "Dummy2",
        data: _lower,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                color: _duration == 1
                    ? Theme.of(context).colorScheme.primaryVariant
                    : Colors.white,
                onPressed: () {
                  setState(() {
                    _closes = _allCloses.sublist(60, 90);
                    _upper = _allUpper.sublist(60, 90);
                    _lower = _allLower.sublist(60, 90);
                    _duration = 1;
                  });
                },
                child: Text(
                  '1 AYLIK',
                  style: TextStyle(
                    color: _duration == 1 ? Colors.white : Colors.black,
                  ),
                ),
              ),
              RaisedButton(
                color: _duration == 2
                    ? Theme.of(context).colorScheme.primaryVariant
                    : Colors.white,
                onPressed: () {
                  setState(() {
                    _closes = _allCloses.sublist(30, 90);
                    _upper = _allUpper.sublist(30, 90);
                    _lower = _allLower.sublist(30, 90);
                    _duration = 2;
                  });
                },
                child: Text(
                  '2 AYLIK',
                  style: TextStyle(
                    color: _duration == 2 ? Colors.white : Colors.black,
                  ),
                ),
              ),
              RaisedButton(
                color: _duration == 3
                    ? Theme.of(context).colorScheme.primaryVariant
                    : Colors.white,
                onPressed: () {
                  setState(() {
                    _closes = _allCloses.sublist(0, 90);
                    _upper = _allUpper.sublist(0, 90);
                    _lower = _allLower.sublist(0, 90);
                    _duration = 3;
                  });
                },
                child: Text(
                  '3 AYLIK',
                  style: TextStyle(
                    color: _duration == 3 ? Colors.white : Colors.black,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
