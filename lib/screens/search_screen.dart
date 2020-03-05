import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/authentication.dart';
import '../widgets/search/stocks_search.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _currentIndex = 0;
  var _isInit = true;
  var _isLoading = false;
  var _myStocks = [];
  var _showedStocks = [];

  void addToMyStocks(stockName) {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    const url = 'http://54.196.2.46/api/portfolio/add';
    http.post(
      url,
      body: json.encode({'user': userId, "name": stockName}),
      headers: {"Content-Type": "application/json"},
    );
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

  void filterOptionResults(String option) {
    List dummySearchList = [];
    dummySearchList.addAll(_myStocks);
    if (option == "increasing") {
      List dummyListData = [];
      dummySearchList.forEach((stock) {
        if (stock['rate'] >= 0) {
          dummyListData.add(stock);
        }
      });
      setState(() {
        _showedStocks.clear();
        _showedStocks.addAll(dummyListData);
      });
      return;
    }
    if (option == "decreasing") {
      List dummyListData = [];
      dummySearchList.forEach((stock) {
        if (stock['rate'] < 0) {
          dummyListData.add(stock);
        }
      });
      setState(() {
        _showedStocks.clear();
        _showedStocks.addAll(dummyListData);
      });
      return;
    }
    if (option == "all") {
      setState(() {
        _showedStocks.clear();
        _showedStocks.addAll(_myStocks);
      });
    }
  }

  void getMyStocks() {
    const stockUrl = 'http://54.196.2.46/api/ticker/all';
    const currencyUrl = 'http://54.196.2.46/api/ticker/currencies';
    var url;
    setState(() {
      _showedStocks.clear();
      _isLoading = true;
    });
    if (_currentIndex == 0) {
      url = stockUrl;
    } else if (_currentIndex == 1) {
      url = currencyUrl;
    }
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
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
    _controller.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              'Search',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            brightness: Theme.of(context).brightness,
            actions: <Widget>[
              PopupMenuButton(
                offset: Offset(50.0, 50.0),
                onSelected: (String selectedValue) {
                  filterOptionResults(selectedValue);
                },
                color: Theme.of(context).colorScheme.primaryVariant,
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                      child: (Text('Sadece Yükselenler')), value: "increasing"),
                  PopupMenuItem(
                      child: (Text('Sadece Düşenler')), value: "decreasing"),
                  PopupMenuItem(child: (Text('Tümünü Göster')), value: "all"),
                ],
              ),
            ],
          ),
          Container(
            height: 40,
            child: TabBar(
              controller: _controller,
              indicatorColor: Colors.white60,
              labelColor: Colors.white,
              tabs: <Widget>[
                Text(
                  "Hisseler",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Dolar / Altın",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor)))
                : TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      StocksSearch(
                        _showedStocks,
                        filterSearchResults,
                        addToMyStocks,
                        refresh,
                      ),
                      StocksSearch(
                        _showedStocks,
                        filterSearchResults,
                        addToMyStocks,
                        refresh,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> refresh() {
    const url = 'http://54.196.2.46/api/ticker/all';
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

  _handleTabSelection() {
    setState(() {
      _currentIndex = _controller.index;
    });
    getMyStocks();
  }
}
