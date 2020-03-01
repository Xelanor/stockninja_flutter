import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import './consecutive-analysis-info.dart';
import '../../screens/stock_details_screen.dart';

class SingleNotification extends StatelessWidget {
  final Map notification;
  final Function refresh;

  SingleNotification(this.notification, this.refresh);

  void onTapNotification(ctx) {
    if (notification['category'] == "target" ||
        notification['category'] == "investment") {
      Navigator.of(ctx)
          .push(
            MaterialPageRoute(
              builder: (context) => StockDetailsScreen(
                  notification['information']['ticker'], false),
            ),
          )
          .whenComplete(refresh);
    } else if (notification['category'] == "consecutive") {
      var stocks = notification['information']['stocks'];
      var increasing = [];
      var decreasing = [];
      stocks.sort(
          (a, b) => double.parse(a['rate']).compareTo(double.parse(b['rate'])));
      for (var i = 0; i < stocks.length; i++) {
        double.parse(stocks[i]['rate']) > 0
            ? increasing.add(stocks[i])
            : decreasing.add(stocks[i]);
      }
      Navigator.of(ctx)
          .push(
            MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return ConsecutiveAnalysisInfo(increasing, decreasing);
              },
              fullscreenDialog: true,
            ),
          )
          .whenComplete(refresh);
    }
    const url = 'http://54.196.2.46/api/notification/viewed';
    http.post(
      url,
      body: json.encode({'id': notification['_id']['\$oid']}),
      headers: {"Content-Type": "application/json"},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapNotification(context);
      },
      child: ListTile(
        leading: Container(
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.trending_down,
            ),
          ),
        ),
        title: Text(notification['title']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(notification['subtitle']),
            Text(
              DateFormat('dd.MM.yyyy')
                  .add_Hm()
                  .format(DateTime.fromMillisecondsSinceEpoch(
                      notification['createdAt']['\$date']))
                  .toString(),
              style: TextStyle(fontSize: 10, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing: Icon(
          notification['viewed']
              ? Icons.radio_button_unchecked
              : Icons.radio_button_checked,
          color: Theme.of(context).colorScheme.secondary,
        ),
        // dense: true,
      ),
    );
  }
}
