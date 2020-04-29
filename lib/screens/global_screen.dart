import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/global/daily_changes.dart';
import '../widgets/global/indicator_search.dart';
import '../widgets/global/ninja_simulation.dart';

class GlobalScreen extends StatefulWidget {
  static const routeName = '/global-screen';

  @override
  _GlobalScreenState createState() => _GlobalScreenState();
}

class _GlobalScreenState extends State<GlobalScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _events = [];

  void getEvents() {
    const url = 'http://3.80.155.110/api/change';
    setState(() {
      _isLoading = true;
    });
    http.get(url).then(
      (response) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        setState(() {
          _isLoading = false;
          _events = extractedData;
        });
      },
    ).catchError((err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    });
  }

  void onRefresh(events) {
    setState(() {
      _events = events;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      getEvents();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  get appBarColor {
    if (_events[0]['decreasing'] > 75) {
      return Colors.red.shade800;
    } else if (_events[0]['decreasing'] > 50) {
      return Colors.red.shade400;
    } else if (_events[0]['decreasing'] > 25) {
      return Colors.green.shade500;
    } else if (_events[0]['decreasing'] > 1) {
      return Colors.green.shade800;
    } else if (_events[0]['decreasing'] == 0) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
              child: TabBar(
                indicatorColor: Colors.white60,
                labelColor: Colors.white,
                tabs: <Widget>[
                  Text(
                    "Simulasyon",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Veriler",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Arama",
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
                      children: <Widget>[
                        NinjaSimulation(),
                        DailyChanges(_events, onRefresh),
                        IndicatorSearch(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
