import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../table/indicator_table_header.dart';
import '../table/indicator_table_row.dart';

class IndicatorSearch extends StatefulWidget {
  @override
  _IndicatorSearchState createState() => _IndicatorSearchState();
}

class _IndicatorSearchState extends State<IndicatorSearch> {
  bool _isLoading = false;
  var _stocks = [];

  int _rsiValue = 40;
  int _ninjaValue = 0;
  double _pdDdValue = 5.0;

  void fetchIndicators() {
    var url = 'http://3.80.155.110/api/ticker/search';
    setState(() {
      _isLoading = true;
    });
    http.post(url,
        body: json.encode({
          'rsi': _rsiValue,
          'ninja': _ninjaValue / 100,
          'pd_dd': _pdDdValue
        }),
        headers: {"Content-Type": "application/json"}).then(
      (response) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        setState(() {
          _isLoading = false;
          _stocks = extractedData;
        });
      },
    ).catchError((err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 35),
            padding: EdgeInsets.only(left: 18),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'RSI MAX Value: $_rsiValue',
                      style: TextStyle(fontSize: 15),
                    ),
                    Expanded(
                      child: Slider(
                        value: _rsiValue.toDouble(),
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: '$_rsiValue',
                        onChanged: (double newValue) {
                          setState(() {
                            _rsiValue = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'NINJA MAX Value: % $_ninjaValue',
                      style: TextStyle(fontSize: 15),
                    ),
                    Expanded(
                      child: Slider(
                        value: _ninjaValue.toDouble(),
                        min: -20,
                        max: 20,
                        divisions: 40,
                        label: '$_ninjaValue',
                        onChanged: (double newValue) {
                          setState(() {
                            _ninjaValue = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'PD/DD Max Value: $_pdDdValue',
                      style: TextStyle(fontSize: 15),
                    ),
                    Expanded(
                      child: Slider(
                        value: _pdDdValue.toDouble(),
                        min: 0.0,
                        max: 30.0,
                        divisions: 300,
                        label: '$_pdDdValue',
                        onChanged: (double newValue) {
                          setState(() {
                            _pdDdValue =
                                double.parse(newValue.toStringAsFixed(1));
                          });
                        },
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text(
                    'Ara',
                    style: TextStyle(fontSize: 16),
                  ),
                  textColor: Colors.black,
                  onPressed: () {
                    fetchIndicators();
                  },
                ),
              ],
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor)))
              : _stocks.length > 0
                  ? Column(
                      children: <Widget>[
                        Text(
                          "${_stocks.length} hisse bulundu...",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        IndicatorTableHeader(),
                        Column(
                            children: _stocks.map<Widget>((stock) {
                          return IndicatorTableRow(stock);
                        }).toList()),
                      ],
                    )
                  : Text('No Result'),
        ],
      ),
    );
  }
}
