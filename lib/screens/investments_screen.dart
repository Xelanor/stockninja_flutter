import 'package:flutter/material.dart';

class InvestmentsScreen extends StatelessWidget {
  static const routeName = '/investments-screen';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text(
            'Center',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          brightness: Theme.of(context).brightness,
        ),
        Expanded(
          child: Center(
            child: Text('Center'),
          ),
        ),
      ],
    );
  }
}
