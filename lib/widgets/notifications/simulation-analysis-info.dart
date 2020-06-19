import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../screens/stock_details_screen.dart';

class SimulationAnalysisInfo extends StatelessWidget {
  final List stocks;

  SimulationAnalysisInfo(this.stocks);

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
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Almaya Değer Hisseler',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: stocks.length == 0
                ? Text(
                    'Almaya değer hisse senedi bulunmamaktadır.',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                : Container(
                    child: GridView.count(
                      childAspectRatio: 0.8,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 4,
                      children: stocks.map((stock) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    StockDetailsScreen(stock, false),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.grey[900],
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  stock,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(1.0),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
