import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/charts/intraday_chart.dart';
import '../widgets/charts/closes_chart.dart';
import '../widgets/charts/rsi_chart.dart';
import '../widgets/charts/triple_chart.dart';
import '../widgets/charts/env_chart.dart';
import '../widgets/charts/ninja_chart.dart';
import '../widgets/charts/ninja2_chart.dart';

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

  Map<String, dynamic> _stockDetails = {};

  void _setTarget(type, target) {
    if (type == "buy") {
      const url = "http://34.67.211.44/api/stock/setbuytarget";
      http.post(url,
          body: json.encode(
              {'name': widget.stockName, 'target': target, 'prevTarget': 0}),
          headers: {"Content-Type": "application/json"}).then((_) {
        setState(() {
          _stockDetails['buyTarget'] = target;
        });
      });
    }

    if (type == "sell") {
      const url = "http://34.67.211.44/api/stock/setselltarget";
      http.post(url,
          body: json.encode(
              {'name': widget.stockName, 'target': target, 'prevTarget': 0}),
          headers: {"Content-Type": "application/json"}).then((_) {
        setState(() {
          _stockDetails['sellTarget'] = target;
        });
      });
    }
  }

  void _stockTransaction(type, price, amount) {
    const url = "http://34.67.211.44/api/transaction/add";
    http.post(url,
        body: json.encode({
          'name': widget.stockName,
          'price': price,
          'amount': amount,
          'type': type
        }),
        headers: {"Content-Type": "application/json"}).then((_) {});
  }

  void startAddNewTargets(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: StockTargetModal(widget.stockName, _setTarget));
        });
  }

  void startTransactionModal(BuildContext ctx, String type) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: StockTransactionModal(
                  widget.stockName, _stockTransaction, type));
        });
  }

  void getStockDetails() {
    var now = DateTime.now();
    var url =
        'http://34.67.211.44/api/single_ticker_details/${widget.stockName}';
    setState(() {
      _isLoading = true;
    });
    http.get(url).then(
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

  String rateCalculator(price, prevClose) {
    var rate = (((price - prevClose) / prevClose) * 100).toStringAsFixed(2);
    return rate;
  }

  @override
  Widget build(BuildContext context) {
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
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 30),
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
          elevation: 0,
          title: Text(
            '${widget.stockName}',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold),
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
            : TabBarView(
                children: <Widget>[
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: widget.increasing
                                  ? Theme.of(context).colorScheme.onSecondary
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                              fontWeight: FontWeight.w600),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                BorderRadius.circular(20)),
                                        onPressed: () {
                                          startTransactionModal(context, "buy");
                                        },
                                        textTheme: ButtonTextTheme.primary,
                                        textColor: double.parse(_rate) >= 0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                            : Theme.of(context)
                                                .colorScheme
                                                .error,
                                      ),
                                    ),
                                    SizedBox(width: 18),
                                    ButtonTheme(
                                      minWidth: 110,
                                      child: OutlineButton(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          'SAT',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        borderSide:
                                            BorderSide(color: Colors.white30),
                                        onPressed: () {
                                          startTransactionModal(
                                              context, "sell");
                                        },
                                        textTheme: ButtonTextTheme.primary,
                                        textColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        IntradayChart(_stockDetails['intraday']),
                        ClosesChart(_stockDetails['closes']),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        RSIChart(_stockDetails['rsi']),
                        TripleChart(
                          _stockDetails['closes'],
                          _stockDetails['triple_index']['first_list'],
                          _stockDetails['triple_index']['second_list'],
                          _stockDetails['triple_index']['third_list'],
                        ),
                        ENVChart(
                          _stockDetails['closes'],
                          _stockDetails['env']['upper'],
                          _stockDetails['env']['lower'],
                        ),
                        NinjaChart(
                          _stockDetails['ninja_index'],
                        ),
                        Ninja2Chart(
                          _stockDetails['ninja_index_s'],
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
