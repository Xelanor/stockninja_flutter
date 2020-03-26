import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/preferences.dart';
import '../widgets/charts/intraday_chart.dart';
import '../widgets/charts/closes_chart.dart';
import '../widgets/charts/rsi_chart.dart';
import '../widgets/charts/triple_chart.dart';
import '../widgets/charts/env_chart.dart';
import '../widgets/charts/ninja_chart.dart';
import '../widgets/charts/ninja2_chart.dart';
import '../widgets/charts/williams_chart.dart';
import '../widgets/charts/aroon_chart.dart';

import '../providers/authentication.dart';
import '../widgets/details/stock_target_modal.dart';
import '../widgets/details/stock_transaction_modal.dart';

class StockDetailsScreen extends StatefulWidget {
  final String stockName;
  final bool increasing;

  StockDetailsScreen(this.stockName, this.increasing);
  static const routeName = '/stock-details-screen';

  @override
  _StockDetailsScreenState createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _rate;
  var _graphPeriod = 30;

  Map<String, dynamic> _stockDetails = {};

  void _setTarget(type, target) {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    if (type == "buy") {
      const url = "http://54.196.2.46/api/portfolio/setbuytarget";
      http.post(url,
          body: json.encode(
              {'name': widget.stockName, 'target': target, 'user': userId}),
          headers: {"Content-Type": "application/json"}).then((_) {
        setState(() {
          _stockDetails['buyTarget'] = target;
        });
      });
    }

    if (type == "sell") {
      const url = "http://54.196.2.46/api/portfolio/setselltarget";
      http.post(url,
          body: json.encode(
              {'name': widget.stockName, 'target': target, 'user': userId}),
          headers: {"Content-Type": "application/json"}).then((_) {
        setState(() {
          _stockDetails['sellTarget'] = target;
        });
      });
    }
  }

  void _stockTransaction(price, amount) {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    const url = "http://54.196.2.46/api/transaction/add";
    http.post(url,
        body: json.encode({
          'user': userId,
          'name': widget.stockName,
          'price': price,
          'amount': amount,
          'remaining': amount,
          'kind': "buy"
        }),
        headers: {"Content-Type": "application/json"}).then((_) {});
  }

  void startAddNewTargets(BuildContext ctx) {
    Navigator.of(ctx).push(
      new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return StockTargetModal(
            widget.stockName,
            _setTarget,
            _stockDetails['price'].toStringAsFixed(2),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void startTransactionModal(BuildContext ctx) {
    Navigator.of(ctx).push(
      new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return StockTransactionModal(
            widget.stockName,
            _stockTransaction,
            _stockDetails['price'].toStringAsFixed(2),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void getStockDetails() {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    var now = DateTime.now();
    var url = 'http://54.196.2.46/api/ticker/single-details';
    setState(() {
      _isLoading = true;
    });
    http.post(
      url,
      body: json.encode({'user': userId, "name": widget.stockName}),
      headers: {"Content-Type": "application/json"},
    ).then(
      (response) {
        print(DateTime.now().difference(now));
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        _rate =
            rateCalculator(extractedData['price'], extractedData['prevClose']);
        setState(() {
          _isLoading = false;
          _stockDetails = extractedData;
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
      getStockDetails();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void filterOptionResults(int option) {
    setState(() {
      _graphPeriod = option;
    });
  }

  String rateCalculator(price, prevClose) {
    var rate = (((price - prevClose) / prevClose) * 100).toStringAsFixed(2);
    return rate;
  }

  @override
  Widget build(BuildContext context) {
    final graphNotifier = Provider.of<GraphNotifier>(context);
    _graphPeriod = (graphNotifier.getGraphPeriod());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_box,
                size: 35,
              ),
              onPressed: () => startAddNewTargets(context),
            ),
            PopupMenuButton(
              offset: Offset(20.0, 50.0),
              onSelected: (int selectedValue) {
                filterOptionResults(selectedValue);
                onGraphPeriodChanged(selectedValue, graphNotifier);
              },
              color: Theme.of(context).colorScheme.primaryVariant,
              icon: Icon(
                Icons.filter_list,
                color: Colors.white,
                size: 35,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: (Text('1 AY')),
                  value: 30,
                ),
                PopupMenuItem(
                  child: (Text('2 AY')),
                  value: 60,
                ),
                PopupMenuItem(
                  child: (Text('3 AY')),
                  value: 90,
                ),
              ],
            ),
          ],
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${widget.stockName} ',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                _isLoading ? '' : '${_stockDetails['shortName']}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          backgroundColor: widget.increasing
              ? Theme.of(context).colorScheme.onSecondary
              : Theme.of(context).colorScheme.error,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onBackground),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).primaryColor)))
            : Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    color: widget.increasing
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.error,
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Şu anki Fiyat',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white60),
                            ),
                            Text(
                              'TL ${_stockDetails['price'].toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(width: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Dünden bu yana',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white60),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '% $_rate',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      height: 1),
                                ),
                                Icon(
                                  double.parse(_rate) >= 0
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  size: 24,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: widget.increasing
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.error,
                    child: TabBar(
                      indicatorColor: Colors.white60,
                      labelColor: Colors.white,
                      tabs: <Widget>[
                        Text(
                          "Veriler",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Tablolar",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: widget.increasing
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                        : Theme.of(context).colorScheme.error,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(150),
                                        bottomLeft: Radius.circular(50))),
                                height: 320,
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Şu anki Fiyat',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white60),
                                              ),
                                              Text(
                                                'TL ${_stockDetails['price'].toStringAsFixed(2)}',
                                                style: TextStyle(
                                                    fontSize: 32,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Dünkü Fiyat',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white60),
                                                ),
                                                Text(
                                                  'TL ${_stockDetails['prevClose'].toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 28),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Dünden bu yana',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white60),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '% $_rate',
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.white,
                                                        height: 1),
                                                  ),
                                                  Icon(
                                                    double.parse(_rate) >= 0
                                                        ? Icons.arrow_upward
                                                        : Icons.arrow_downward,
                                                    size: 32,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Alış Hedefi',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white60),
                                                ),
                                                Text(
                                                  'TL ${_stockDetails['buyTarget'].toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'Satış Hedefi',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white60),
                                                ),
                                                Text(
                                                  'TL ${_stockDetails['sellTarget'].toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      ButtonBar(
                                        buttonPadding: EdgeInsets.all(0),
                                        alignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: 110,
                                            child: RaisedButton(
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                'SATIN AL',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              onPressed: () {
                                                startTransactionModal(context);
                                              },
                                              textTheme:
                                                  ButtonTextTheme.primary,
                                              textColor:
                                                  double.parse(_rate) >= 0
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .onSecondary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .error,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IntradayChart(_stockDetails['intraday']),
                              ClosesChart(
                                  _stockDetails['closes'], _graphPeriod),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              _stockDetails['rsi'].length > 0
                                  ? RSIChart(_stockDetails['rsi'], _graphPeriod)
                                  : Container(),
                              TripleChart(
                                _stockDetails['closes'],
                                _stockDetails['triple_index']['first_list'],
                                _stockDetails['triple_index']['second_list'],
                                _stockDetails['triple_index']['third_list'],
                                _graphPeriod,
                              ),
                              ENVChart(
                                _stockDetails['closes'],
                                _stockDetails['env']['upper'],
                                _stockDetails['env']['lower'],
                                _graphPeriod,
                              ),
                              WilliamsChart(
                                  _stockDetails['williams'], _graphPeriod),
                              AroonChart(
                                  _stockDetails['aroon']['upper'],
                                  _stockDetails['aroon']['lower'],
                                  _graphPeriod),
                              NinjaChart(
                                _stockDetails['ninja_index'],
                                _graphPeriod,
                              ),
                              Ninja2Chart(
                                _stockDetails['ninja_index_s'],
                                _graphPeriod,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void onGraphPeriodChanged(
      int selectedValue, GraphNotifier graphNotifier) async {
    graphNotifier.setGraphPeriod(selectedValue);
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('graphPeriod', selectedValue);
  }
}
