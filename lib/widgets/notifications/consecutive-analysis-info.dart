import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../screens/stock_details_screen.dart';

class ConsecutiveAnalysisInfo extends StatelessWidget {
  final List increasing;
  final List decreasing;

  ConsecutiveAnalysisInfo(this.increasing, this.decreasing);

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
              'Değer Kaybedenler',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: decreasing.length == 0
                ? Text(
                    'Değer kaybeden hisse senedi bulunmamaktadır.',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                : Container(
                    child: GridView.count(
                      childAspectRatio: 0.8,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 4,
                      children: decreasing.map((stock) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    StockDetailsScreen(stock['name'], false),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.grey[900],
                            padding: EdgeInsets.all(10.0),
                            child: GridTile(
                              header: Text(
                                stock['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              footer: Column(
                                children: <Widget>[
                                  Text(
                                    '${stock['days']} günde',
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    stock['rate'],
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Icon(
                                  Icons.trending_down,
                                  color: Colors.red[400],
                                ),
                              ),
                            ),
                            margin: EdgeInsets.all(1.0),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Değer Kazananlar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: increasing.length == 0
                ? Text(
                    'Değer kazanan hisse senedi bulunmamaktadır.',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                : Container(
                    child: GridView.count(
                      childAspectRatio: 0.8,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 4,
                      children: increasing.map((stock) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    StockDetailsScreen(stock['name'], true),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.grey[900],
                            padding: EdgeInsets.all(10.0),
                            child: GridTile(
                              header: Text(
                                stock['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              footer: Column(
                                children: <Widget>[
                                  Text(
                                    '${stock['days']} günde',
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    stock['rate'],
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              child: Transform.rotate(
                                angle: 270 * math.pi / 180,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Icon(
                                    Icons.trending_down,
                                    color: Colors.green[400],
                                  ),
                                ),
                              ),
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
