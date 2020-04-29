import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/authentication.dart';
import '../widgets/investments/investment_summary.dart';
import '../widgets/investments/investments_list.dart';
import '../widgets/investments/transaction_history.dart';

class InvestmentsScreen extends StatefulWidget {
  static const routeName = '/investments-screen';

  @override
  _InvestmentsScreenState createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _myTransactions = {};
  var _allTransactions = {};
  var screen = "Investments";

  void getMyStocks() {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    const url = 'http://3.80.155.110/api/transaction';
    setState(() {
      _isLoading = true;
    });
    http.post(
      url,
      body: json.encode({'user': userId}),
      headers: {"Content-Type": "application/json"},
    ).then(
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

  void getTransactionHistory() {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    const url = 'http://3.80.155.110/api/transaction/mixed';
    setState(() {
      _isLoading = true;
    });
    http.post(
      url,
      body: json.encode({'user': userId}),
      headers: {"Content-Type": "application/json"},
    ).then(
      (response) {
        final extractedData = json.decode(response.body) as Map;
        setState(() {
          _isLoading = false;
          _allTransactions = extractedData;
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
              : _myTransactions.length == 0
                  ? Center(child: Text('No transactions'))
                  : RefreshIndicator(
                      onRefresh: refresh,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: InvestmentSummary(
                                _myTransactions['total_equity']
                                    .toStringAsFixed(2),
                                _myTransactions['potential_profit_loss']
                                    .toStringAsFixed(2),
                                _myTransactions['total_profit']
                                    .toStringAsFixed(2),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 36,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          screen = "Investments";
                                        });
                                        getMyStocks();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.5,
                                                color: screen == "Investments"
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                    : Colors.transparent),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        height: 36,
                                        child: Text(
                                          'Yatırımlar',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          screen = "History";
                                        });
                                        getTransactionHistory();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.5,
                                                color: screen != "Investments"
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                    : Colors.transparent),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        height: 36,
                                        child: Text(
                                          'İşlem Geçmişi',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: screen == "Investments"
                                  ? InvestmentsList(
                                      _myTransactions, getMyStocks)
                                  : TransactionHistory(_allTransactions),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ],
    );
  }

  Future<void> refresh() {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    const url = 'http://12.0.2.2:5000/api/transaction';
    http.post(
      url,
      body: json.encode({'user': userId}),
      headers: {"Content-Type": "application/json"},
    ).then(
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
