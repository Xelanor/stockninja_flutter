import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../charts/change_chart.dart';
import '../table/event_table_header.dart';
import '../table/event_table_row.dart';

class DailyChanges extends StatelessWidget {
  final List events;
  final Function onRefresh;

  DailyChanges(this.events, this.onRefresh);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ChangeChart(events),
        EventTableHeader(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              physics: BouncingScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (_, i) {
                if (events[i]['date'].substring(11, 13) != "13") {
                  return EventTableRow(events[i]);
                } else {
                  return Column(
                    children: <Widget>[
                      EventTableRow(events[i]),
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
    );
  }

  Future<void> refresh() {
    const url = 'http://3.80.155.110/api/change';
    http.get(url).then(
      (response) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        onRefresh(extractedData);
      },
    ).catchError((err) {
      print(err);
    });
    return Future.value();
  }
}
