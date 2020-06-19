import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import './consecutive-analysis-info.dart';
import './simulation-analysis-info.dart';
import '../../screens/stock_details_screen.dart';

class SingleNotification extends StatelessWidget {
  final Map notification;
  final Function refresh;
  final Function deleteNotification;

  SingleNotification(this.notification, this.refresh, this.deleteNotification);

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
    } else if (notification['category'] == "simulation") {
      var stocks = notification['information']['tickers'];
      Navigator.of(ctx)
          .push(
            MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return SimulationAnalysisInfo(stocks);
              },
              fullscreenDialog: true,
            ),
          )
          .whenComplete(refresh);
    }
    const url = 'http://3.80.155.110/api/notification/viewed';
    http.post(
      url,
      body: json.encode({'id': notification['_id']['\$oid']}),
      headers: {"Content-Type": "application/json"},
    );
  }

  bool _showDeleteNotificationDialog(ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text("Bildirimi silmek istediğinizden emin misiniz?"),
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
                deleteNotification(notification['_id']['\$oid']);
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
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(notification['_id']['\$oid']),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: Icon(Icons.delete),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.all(1),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        _showDeleteNotificationDialog(context);
        return;
      },
      child: InkWell(
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
      ),
    );
  }
}
