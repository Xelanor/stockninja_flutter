import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ClosesChart extends StatefulWidget {
  final List<dynamic> data;

  ClosesChart(this.data);

  @override
  _ClosesChartState createState() => _ClosesChartState();
}

class _ClosesChartState extends State<ClosesChart> {
  var _isInit = true;
  var _duration = 1;
  var _allData;
  var _data;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _allData = widget.data;
      _data = widget.data.sublist(60, 90);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, int>> series = [
      charts.Series(
        id: "Closes",
        data: _data,
        domainFn: (point, i) => i,
        measureFn: (point, i) => point,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(134, 65, 244, 1)),
      ),
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Kapanışlar',
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
                    zeroBound: false,
                    desiredTickCount: 10,
                    dataIsInWholeNumbers: false),
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
                    _data = _allData.sublist(60, 90);
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
                    _data = _allData.sublist(30, 90);
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
                    _data = _allData.sublist(0, 90);
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
