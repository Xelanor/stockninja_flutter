import 'package:flutter/material.dart';

import '../../widgets/simulation/tickers.dart';

class SelectStocks extends StatefulWidget {
  @override
  _SelectStocksState createState() => _SelectStocksState();
}

class _SelectStocksState extends State<SelectStocks> {
  var stocks = tickers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        brightness: Theme.of(context).brightness,
        title: Text(''),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, stocks);
        },
        child: Icon(Icons.thumb_up),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              'Simülasyonda kullanmak istediğiniz hisse senetlerini seçin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: stocks.keys.map((key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: stocks[key],
                  onChanged: (bool value) {
                    setState(() {
                      stocks[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
