import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../widgets/table/stock_table_header.dart';
import '../widgets/table/stock_table_row.dart';

class HomepageScreen extends StatefulWidget {
  static const routeName = '/homepage-screen';

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _myStocks = [];

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

    // OneSignal.shared
    //     .setNotificationReceivedHandler((OSNotification notification) {
    //   print("new notif");
    //   print(notification);
    // });

    // OneSignal.shared
    //     .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    //   print("opened notif");
    //   print(result);
    // });
  }

  void getMyStocks() {
    var now = DateTime.now();
    const url = 'http://34.67.211.44/api/my_ticker_details';
    setState(() {
      _isLoading = true;
    });
    http.get(url).then(
      (response) {
        print(DateTime.now().difference(now));
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
                    itemBuilder: (_, i) => StockTableRow(_myStocks[i]),
                  ),
                ),
              ),
            ],
          );
  }

  Future<void> refresh() {
    const url = 'http://34.67.211.44/api/my_ticker_details';
    http.get(url).then(
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
