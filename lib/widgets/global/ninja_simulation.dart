import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../widgets/charts/simulation_chart.dart';
import '../../widgets/simulation/condition_row.dart';
import '../../widgets/simulation/widgets/text_button.dart';
import '../../widgets/simulation/select_stocks.dart';
import '../../providers/authentication.dart';

class NinjaSimulation extends StatefulWidget {
  @override
  _NinjaSimulationState createState() => _NinjaSimulationState();
}

class _NinjaSimulationState extends State<NinjaSimulation> {
  Map buyConditions = {
    "stock_type": "",
    "stocks": {},
    "price": {
      "priceDay": 0,
      "pricePercentage": 1.0,
      "priceCondition": "",
      "checked": false,
      "expanded": false,
    },
    "triple": {
      "price": 4,
      "short_value": 3,
      "medium_value": 2,
      "long_value": 1,
      "price_compare": "",
      "short_compare": "",
      "medium_compare": "",
      "long_compare": "",
      "short": 7,
      "medium": 14,
      "long": 21,
      "checked": false,
      "expanded": false,
    },
    "rsi": {
      "first_compare": "",
      "second_compare": "",
      "third_compare": "",
      "rsi_value": 70,
      "rsi_compare": "",
      "checked": false,
      "expanded": false,
    },
    "aroon": {
      "up_lower": 0,
      "up_upper": 100,
      "down_lower": 0,
      "down_upper": 100,
      "aroon_compare": "",
      "uptrend": "",
      "downtrend": "",
      "checked": false,
      "expanded": false,
    },
    "after_sell": {
      "percent": 0,
      "period": 0,
      "checked": false,
      "expanded": false,
    },
  };

  Map sellConditions = {
    "price": {
      "priceDay": 0,
      "pricePercentage": 1.0,
      "priceCondition": "",
      "checked": false,
      "expanded": false,
    },
    "triple": {
      "price": 1,
      "short_value": 2,
      "medium_value": 3,
      "long_value": 4,
      "price_compare": "",
      "short_compare": "",
      "medium_compare": "",
      "long_compare": "",
      "short": 7,
      "medium": 14,
      "long": 21,
      "checked": false,
      "expanded": false,
    },
    "rsi": {
      "first_compare": "",
      "second_compare": "",
      "third_compare": "",
      "rsi_value": 70,
      "rsi_compare": "",
      "checked": false,
      "expanded": false,
    },
    "trace": {
      "value": 0,
      "checked": false,
      "expanded": false,
    }
  };
  var chartData = [];
  var buyDays = [];
  var sellDays = [];

  void changeStocks(category, condition, value) {
    setState(() {
      buyConditions["stock_type"] = value;
    });
  }

  void expandBuyCondition(category) {
    var expanded = buyConditions[category]["expanded"];
    setState(() {
      buyConditions[category]["expanded"] = !expanded;
    });
  }

  void expandSellCondition(category) {
    var expanded = sellConditions[category]["expanded"];
    setState(() {
      sellConditions[category]["expanded"] = !expanded;
    });
  }

  void checkBuyCondition(category, bool value) {
    setState(() {
      buyConditions[category]["checked"] = value;
    });
  }

  void checkSellCondition(category, bool value) {
    setState(() {
      sellConditions[category]["checked"] = value;
    });
  }

  void changeBuyCondition(category, condition, value) {
    setState(() {
      buyConditions[category][condition] = value;
    });
  }

  void changeSellCondition(category, condition, value) {
    setState(() {
      sellConditions[category][condition] = value;
    });
  }

  void _onLoading() {
    setState(() {
      chartData = [];
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Tahmini Bekleme Süresi"),
                Text("5 Saniye"),
              ],
            ),
          ),
        );
      },
    );
    Future.delayed(new Duration(seconds: 1), () {
      getSimulationResult();
      Navigator.pop(context); //pop dialog
    });
  }

  void getSimulationResult() {
    const url = 'http://3.80.155.110/api/simulation';
    http.post(
      url,
      body: json.encode({
        'buy': buyConditions,
        'sell': sellConditions,
        "period": "yearly",
      }),
      headers: {"Content-Type": "application/json"},
    ).then(
      (response) {
        final extractedData =
            json.decode(response.body) as Map<dynamic, dynamic>;
        setState(() {
          chartData = extractedData['values'];
          buyDays = extractedData['buy_days'];
          sellDays = extractedData['sell_days'];
        });
      },
    ).catchError((err) {
      print(err);
    });
  }

  void saveSimulationRecords() {
    var userId =
        Provider.of<AuthNotifier>(context, listen: false).getUserInfo['id'];
    const url = 'http://3.80.155.110/api/simulation/save';
    http.post(
      url,
      body: json.encode({
        'buy': buyConditions,
        'sell': sellConditions,
        'user': userId,
      }),
      headers: {"Content-Type": "application/json"},
    ).then(
      (response) {
        print("Done");
      },
    ).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  "Yükselenler",
                  changeStocks,
                  buyConditions["stock_type"],
                  "",
                  "",
                ),
                TextButton(
                  "Düşenler",
                  changeStocks,
                  buyConditions["stock_type"],
                  "",
                  "",
                ),
                InkWell(
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SelectStocks();
                        },
                        fullscreenDialog: true,
                      ),
                    );
                    setState(() {
                      buyConditions['stock_type'] = "Özel";
                      buyConditions['stocks'] = result;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: "Özel" == buyConditions["stock_type"]
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[700],
                      ),
                      color: "Özel" == buyConditions["stock_type"]
                          ? Theme.of(context).colorScheme.primaryVariant
                          : Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Özel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'ALIM KOŞULLARI',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          ConditionRow(
            "Fiyat",
            buyConditions["price"]["checked"],
            buyConditions["price"]["expanded"],
            "price",
            expandBuyCondition,
            checkBuyCondition,
            buyConditions["price"],
            changeBuyCondition,
          ),
          ConditionRow(
            "Triple Index",
            buyConditions["triple"]["checked"],
            buyConditions["triple"]["expanded"],
            "triple",
            expandBuyCondition,
            checkBuyCondition,
            buyConditions["triple"],
            changeBuyCondition,
          ),
          ConditionRow(
            "RSI Index",
            buyConditions["rsi"]["checked"],
            buyConditions["rsi"]["expanded"],
            "rsi",
            expandBuyCondition,
            checkBuyCondition,
            buyConditions["rsi"],
            changeBuyCondition,
          ),
          ConditionRow(
            "Aroon Index",
            buyConditions["aroon"]["checked"],
            buyConditions["aroon"]["expanded"],
            "aroon",
            expandBuyCondition,
            checkBuyCondition,
            buyConditions["aroon"],
            changeBuyCondition,
          ),
          // SimBuyConditions(buyConditions, changeBuyCondition),
          SizedBox(height: 40),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'SATIM KOŞULLARI',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          ConditionRow(
            "Fiyat",
            sellConditions["price"]["checked"],
            sellConditions["price"]["expanded"],
            "price",
            expandSellCondition,
            checkSellCondition,
            sellConditions["price"],
            changeSellCondition,
          ),
          ConditionRow(
            "Triple Index",
            sellConditions["triple"]["checked"],
            sellConditions["triple"]["expanded"],
            "triple",
            expandSellCondition,
            checkSellCondition,
            sellConditions["triple"],
            changeSellCondition,
          ),
          ConditionRow(
            "RSI Index",
            sellConditions["rsi"]["checked"],
            sellConditions["rsi"]["expanded"],
            "rsi",
            expandSellCondition,
            checkSellCondition,
            sellConditions["rsi"],
            changeSellCondition,
          ),
          ConditionRow(
            "İz Süren",
            sellConditions["trace"]["checked"],
            sellConditions["trace"]["expanded"],
            "trace",
            expandSellCondition,
            checkSellCondition,
            sellConditions["trace"],
            changeSellCondition,
          ),
          SizedBox(height: 40),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'SATIM SONRASI',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          ConditionRow(
            "Bekleme",
            buyConditions["after_sell"]["checked"],
            buyConditions["after_sell"]["expanded"],
            "after_sell",
            expandBuyCondition,
            checkBuyCondition,
            buyConditions["after_sell"],
            changeBuyCondition,
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton(
                    onPressed: _onLoading,
                    color: Theme.of(context).colorScheme.primaryVariant,
                    child: Text(
                      'Çalıştır',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton(
                    onPressed: saveSimulationRecords,
                    color: Theme.of(context).colorScheme.primary,
                    child: Text(
                      'Kaydet',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),

          chartData.length == 0
              ? Text("YOK")
              : Column(
                  children: <Widget>[
                    Container(
                      child: SimulationChart(chartData),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text('Alım Günleri: ${buyDays.toString()}'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text('Satım Günleri: ${sellDays.toString()}'),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
