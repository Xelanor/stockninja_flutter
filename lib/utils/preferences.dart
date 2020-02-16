import 'package:flutter/material.dart';

class GraphNotifier with ChangeNotifier {
  int _graphPeriod;

  GraphNotifier(this._graphPeriod);

  getGraphPeriod() => _graphPeriod;

  setGraphPeriod(int graphPeriod) async {
    _graphPeriod = graphPeriod;
    notifyListeners();
  }
}
