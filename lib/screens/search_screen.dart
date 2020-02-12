import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/table/stock_table_header.dart';
import '../widgets/table/stock_table_search_row.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _myStocks = [];

  void addToMyStock(stockName) {
    const url = 'http://34.67.211.44/api/stock/add';
    http.post(url, body: {'name': stockName});
  }

  void getMyStocks() {
    const url = 'http://34.67.211.44/api/all_ticker_details';
    setState(() {
      _isLoading = true;
    });
    http.get(url).then(
      (response) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        setState(() {
          _isLoading = false;
          _myStocks = extractedData.sublist(0, extractedData.length - 2);
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
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor)))
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              StockTableHeader(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _myStocks.length,
                    itemBuilder: (_, i) =>
                        StockTableSearchRow(_myStocks[i], addToMyStock),
                  ),
                ),
              ),
            ],
          );
  }

  Future<void> refresh() {
    const url = 'http://34.67.211.44/api/all_ticker_details';
    http.get(url).then(
      (response) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        setState(() {
          _myStocks = extractedData.sublist(0, extractedData.length - 2);
        });
      },
    ).catchError((err) {
      print(err);
    });
    return Future.value();
  }
}
