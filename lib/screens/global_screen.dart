import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/table/event_table_header.dart';
import '../widgets/table/event_table_row.dart';

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
    const url = 'http://34.67.211.44/api/change';
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
    return Column(
      children: <Widget>[
        AppBar(
          title: Text(
            'Global',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: appBarColor,
          brightness: Theme.of(context).brightness,
        ),
        Expanded(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor)))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    EventTableHeader(),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: refresh,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          physics: BouncingScrollPhysics(),
                          itemCount: _events.length,
                          itemBuilder: (_, i) {
                            if (i % 2 == 0) {
                              return EventTableRow(_events[i]);
                            } else {
                              return Column(
                                children: <Widget>[
                                  EventTableRow(_events[i]),
                                  Divider(
                                    color: Colors.orange.shade500,
                                    height: 0.8,
                                  )
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Future<void> refresh() {
    const url = 'http://34.67.211.44/api/change';
    http.get(url).then(
      (response) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        setState(() {
          _events = extractedData;
        });
      },
    ).catchError((err) {
      print(err);
    });
    return Future.value();
  }
}
