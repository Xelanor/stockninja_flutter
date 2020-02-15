import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/investments/stock_card.dart';
import '../widgets/investments/investment_summary.dart';

class InvestmentsScreen extends StatefulWidget {
  static const routeName = '/investments-screen';

  @override
  _InvestmentsScreenState createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _myTransactions = {};

  void getMyStocks() {
    const url =
        'https://j4v2h2jt8b.execute-api.us-west-2.amazonaws.com/dev/ninja/investment_screen_calculator';
    setState(() {
      _isLoading = true;
    });
    http.get(url).then(
      (response) {
        final extractedData = json.decode(response.body) as Map;
        setState(() {
          _isLoading = false;
          _myTransactions = extractedData;
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
  void didChangeDependencies() {
    if (_isInit) {
      getMyStocks();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text(
            'Yatırımlar',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          brightness: Theme.of(context).brightness,
        ),
        Expanded(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor)))
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          InvestmentSummary(
                            _myTransactions['total_equity'].toStringAsFixed(2),
                            _myTransactions['potential_profit_loss']
                                .toStringAsFixed(2),
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: _myTransactions['stock_values']
                                .keys
                                .toList()
                                .map<Widget>((stockName) {
                              return StockCard(
                                stockName,
                                _myTransactions['stock_values'][stockName],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> refresh() {
    const url =
        'https://j4v2h2jt8b.execute-api.us-west-2.amazonaws.com/dev/ninja/investment_screen_calculator';
    http.get(url).then(
      (response) {
        final extractedData = json.decode(response.body) as Map;
        setState(() {
          _myTransactions = extractedData;
        });
      },
    ).catchError((err) {
      print(err);
    });
    return Future.value();
  }
}
