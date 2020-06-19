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

  Map _rsiValues = {"lower": 30, "upper": 70};
  Map _ninjaValues = {"lower": 0, "upper": 5};
  Map _ninja_s_Values = {"lower": 0, "upper": 5};
  Map _pdDdValues = {"lower": 5, "upper": 10};
  Map _fkValues = {"lower": 0, "upper": 20};

  void fetchIndicators() {
    var url = 'http://3.80.155.110/api/ticker/search';
    setState(() {
      _isLoading = true;
    });
    http.post(url,
        body: json.encode(
          {
            'rsi': _rsiValues,
            'ninja': _ninjaValues,
            'ninja_s': _ninja_s_Values,
            'pd_dd': _pdDdValues,
            'fk': _fkValues,
          },
        ),
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
                      'RSI Min - Max',
                      style: TextStyle(fontSize: 15),
                    ),
                    Expanded(
                      child: RangeSlider(
                        values: RangeValues(_rsiValues["lower"].toDouble(),
                            _rsiValues["upper"].toDouble()),
                        min: 0,
                        max: 100,
                        divisions: 100,
                        labels: RangeLabels(
                            '${_rsiValues["lower"]}', '${_rsiValues["upper"]}'),
                        onChanged: (RangeValues newRange) {
                          setState(() {
                            _rsiValues["lower"] = newRange.start.round();
                            _rsiValues["upper"] = newRange.end.round();
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
                      'NINJA Min - Max',
                      style: TextStyle(fontSize: 15),
                    ),
                    Expanded(
                      child: RangeSlider(
                        values: RangeValues(_ninjaValues["lower"].toDouble(),
                            _ninjaValues["upper"].toDouble()),
                        min: -80,
                        max: 20,
                        divisions: 40,
                        labels: RangeLabels('${_ninjaValues["lower"]}',
                            '${_ninjaValues["upper"]}'),
                        onChanged: (RangeValues newRange) {
                          setState(() {
                            _ninjaValues["lower"] = newRange.start.round();
                            _ninjaValues["upper"] = newRange.end.round();
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
                      'NINJA 2 Min - Max',
                      style: TextStyle(fontSize: 15),
                    ),
                    Expanded(
                      child: RangeSlider(
                        values: RangeValues(_ninja_s_Values["lower"].toDouble(),
                            _ninja_s_Values["upper"].toDouble()),
                        min: -80,
                        max: 20,
                        divisions: 40,
                        labels: RangeLabels('${_ninja_s_Values["lower"]}',
                            '${_ninja_s_Values["upper"]}'),
                        onChanged: (RangeValues newRange) {
                          setState(() {
                            _ninja_s_Values["lower"] = newRange.start.round();
                            _ninja_s_Values["upper"] = newRange.end.round();
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
                      'PD/DD Min - Max',
                      style: TextStyle(fontSize: 15),
                    ),
                    Expanded(
                      child: RangeSlider(
                        values: RangeValues(_pdDdValues["lower"].toDouble(),
                            _pdDdValues["upper"].toDouble()),
                        min: 0.0,
                        max: 30.0,
                        divisions: 300,
                        labels: RangeLabels('${_pdDdValues["lower"]}',
                            '${_pdDdValues["upper"]}'),
                        onChanged: (RangeValues newRange) {
                          setState(() {
                            _pdDdValues["lower"] = newRange.start.round();
                            _pdDdValues["upper"] = newRange.end.round();
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
                      'F/K Min - Max',
                      style: TextStyle(fontSize: 15),
                    ),
                    Expanded(
                      child: RangeSlider(
                        values: RangeValues(_fkValues["lower"].toDouble(),
                            _fkValues["upper"].toDouble()),
                        min: 0.0,
                        max: 50,
                        divisions: 100,
                        labels: RangeLabels(
                            '${_fkValues["lower"]}', '${_fkValues["upper"]}'),
                        onChanged: (RangeValues newRange) {
                          setState(() {
                            _fkValues["lower"] = newRange.start.round();
                            _fkValues["upper"] = newRange.end.round();
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
