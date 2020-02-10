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
    var now = DateTime.now();
    const url = 'http://34.67.211.44/api/change';
    setState(() {
      _isLoading = true;
    });
    http.get(url).then(
      (response) {
        print(DateTime.now().difference(now));
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
              EventTableHeader(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _events.length,
                    itemBuilder: (_, i) => EventTableRow(_events[i]),
                  ),
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
