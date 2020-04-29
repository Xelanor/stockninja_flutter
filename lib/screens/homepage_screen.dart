import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/authentication.dart';

import '../widgets/table/stock_table_header.dart';
import '../widgets/table/stock_table_my_row.dart';

class HomepageScreen extends StatefulWidget {
  static const routeName = '/homepage-screen';

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _myStocks = [];

  bool removeMyStock(stockName) {
    if (_showRemoveStockDialog(stockName) == true) {
      return true;
    }
    return false;
  }

  bool _showRemoveStockDialog(stockName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title:
              Text("$stockName portföyden çıkarmak istediğinize emin misiniz?"),
          actions: <Widget>[
            RaisedButton(
              color: Theme.of(context).colorScheme.primary,
              child: Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
                return false;
              },
            ),
            FlatButton(
              child: Text("Devam"),
              onPressed: () {
                var userId = Provider.of<AuthNotifier>(context, listen: false)
                    .getUserInfo['id'];
                const url = 'http://3.80.155.110/api/portfolio/delete';
                var index = _myStocks
                    .indexWhere((stock) => stock['stockName'] == stockName);
                setState(() {
                  _myStocks.removeAt(index);
                });
                http.post(
                  url,
                  body: json.encode({'name': stockName, 'user': userId}),
                  headers: {"Content-Type": "application/json"},
                );
                Navigator.of(context).pop();
                return true;
              },
            ),
          ],
        );
      },
    );
    return false;
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    await OneSignal.shared.init("9c10c48a-a1b3-4d23-8f2c-d9adb16f38fc",
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: true
        });

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  void getMyStocks() {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    const url = 'http://3.80.155.110/api/portfolio';
    setState(() {
      _isLoading = true;
    });
    http.post(
      url,
      body: json.encode({'user': userId}),
      headers: {"Content-Type": "application/json"},
    ).then(
      (response) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        setState(() {
          _isLoading = false;
          _myStocks = extractedData;
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
            'StockNinja',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          brightness: Theme.of(context).brightness,
        ),
        StockTableHeader(),
        _isLoading
            ? Expanded(
                child: Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor))),
              )
            : _myStocks.length == 0
                ? Expanded(child: Center(child: Text('Portföyünüz boş')))
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: refresh,
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: _myStocks.length,
                        itemBuilder: (_, i) =>
                            StockTableMyRow(_myStocks[i], removeMyStock),
                      ),
                    ),
                  ),
      ],
    );
  }

  Future<void> refresh() {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    const url = 'http://3.80.155.110/api/portfolio';
    http.post(
      url,
      body: json.encode({'user': userId}),
      headers: {"Content-Type": "application/json"},
    ).then(
      (response) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        setState(() {
          _myStocks = extractedData;
        });
      },
    ).catchError((err) {
      print(err);
    });
    return Future.value();
  }
}
