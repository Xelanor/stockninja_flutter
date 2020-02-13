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
  final _searchController = TextEditingController();
  var _isInit = true;
  var _isLoading = false;
  var _myStocks = [];
  var _showedStocks = [];

  void addToMyStock(stockName) {
    const url = 'http://34.67.211.44/api/stock/add';
    http.post(url, body: {'name': stockName});
  }

  void filterSearchResults(String query) {
    List dummySearchList = [];
    dummySearchList.addAll(_myStocks);
    if (query.isNotEmpty) {
      List dummyListData = [];
      dummySearchList.forEach((stock) {
        if (stock['stockName'].toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(stock);
        }
      });
      setState(() {
        _showedStocks.clear();
        _showedStocks.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _showedStocks.clear();
        _showedStocks.addAll(_myStocks);
      });
    }
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
          _showedStocks = extractedData.sublist(0, extractedData.length - 2);
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
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StockTableHeader(),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  height: 40,
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    textCapitalization: TextCapitalization.characters,
                    controller: _searchController,
                    decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.background,
                        filled: true,
                        contentPadding: EdgeInsets.all(0),
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _showedStocks.length,
                      itemBuilder: (_, i) =>
                          StockTableSearchRow(_showedStocks[i], addToMyStock),
                    ),
                  ),
                ),
              ],
            ),
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
