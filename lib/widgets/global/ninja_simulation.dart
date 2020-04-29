import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../widgets/charts/simulation_chart.dart';
import '../../widgets/simulation/condition_row.dart';
import '../../widgets/simulation/widgets/text_button.dart';
import '../../widgets/simulation/select_stocks.dart';

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
      "short": 7,
      "long": 21,
      "first": "",
      "second": "",
      "third": "",
      "first_compare": "",
      "second_compare": "",
      "first_percentage": 1.0,
      "second_percentage": 1.0,
      "checked": false,
      "expanded": false,
    }
  };

  Map sellConditions = {
    "price": {
      "priceDay": 0,
      "pricePercentage": 1.0,
      "priceCondition": "",
      "checked": false,
      "expanded": false,
    },
  };
  var chartData = [];

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
      body: json.encode({'buy': buyConditions, 'sell': sellConditions}),
      headers: {"Content-Type": "application/json"},
    ).then(
      (response) {
        final extractedData =
            json.decode(response.body) as Map<dynamic, dynamic>;
        setState(() {
          chartData = extractedData['values'];
        });
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
          SizedBox(height: 40),
          ButtonTheme(
            minWidth: 200,
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
          chartData.length == 0
              ? Text("YOK")
              : Container(
                  child: SimulationChart(chartData),
                )
        ],
      ),
    );
  }
}
