import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TripleChart extends StatefulWidget {
  final List<dynamic> closes;
  final List<dynamic> first_list;
  final List<dynamic> second_list;
  final List<dynamic> third_list;

  TripleChart(this.closes, this.first_list, this.second_list, this.third_list);

  @override
  _TripleChartState createState() => _TripleChartState();
}

class _TripleChartState extends State<TripleChart> {
  var _isInit = true;
  var _duration = 1;
  var _allCloses;
  var _allFirst;
  var _allSecond;
  var _allThird;
  var _closes;
  var _first;
  var _second;
  var _third;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _allCloses = widget.closes;
      _allFirst = widget.first_list;
      _allSecond = widget.second_list;
      _allThird = widget.third_list;
      _closes = widget.closes.sublist(60, 90);
      _first = widget.first_list.sublist(60, 90);
      _second = widget.second_list.sublist(60, 90);
      _third = widget.third_list.sublist(60, 90);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, int>> series = [
      charts.Series(
        id: "Closes",
        data: _closes,
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(134, 65, 244, 1)),
      ),
      charts.Series(
        id: "First",
        data: _first,
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
      ),
      charts.Series(
        id: "Second",
        data: _second,
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
      ),
      charts.Series(
        id: "Third",
        data: _third,
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
      ),
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Triple Index',
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
                    _first = _allFirst.sublist(60, 90);
                    _second = _allSecond.sublist(60, 90);
                    _third = _allThird.sublist(60, 90);
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
                    _first = _allFirst.sublist(30, 90);
                    _second = _allSecond.sublist(30, 90);
                    _third = _allThird.sublist(30, 90);
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
                    _first = _allFirst.sublist(0, 90);
                    _second = _allSecond.sublist(0, 90);
                    _third = _allThird.sublist(0, 90);
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
