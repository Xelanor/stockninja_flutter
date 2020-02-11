import 'package:flutter/material.dart';

import './event_table_str_cell.dart';
import './event_table_int_cell.dart';

class EventTableRow extends StatelessWidget {
  final Map stock;

  EventTableRow(this.stock);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 1.5),
      child: Row(
        children: [
          Expanded(
            child: EventTableStrCell(stock['date']),
            flex: 30,
          ),
          Expanded(
            child: EventTableIntCell('% ${stock["decreasing"]}'),
            flex: 20,
          ),
          Expanded(
            child: EventTableIntCell('% ${stock["increasing"]}'),
            flex: 20,
          ),
          Expanded(
            child: EventTableIntCell('% ${stock["same"]}'),
            flex: 20,
          ),
          Expanded(
            child: EventTableIntCell('${stock["bist"].toStringAsFixed(0)}'),
            flex: 20,
          ),
        ],
      ),
    );
  }
}
