import 'package:flutter/material.dart';

class AuthNotifier with ChangeNotifier {
  Map _userInfo;
  bool _isAuthenticated = false;

  AuthNotifier(this._userInfo, this._isAuthenticated);

  Map get getUserInfo => _userInfo;
  bool get getUserAuthState => _isAuthenticated;

  setUserInfo(Map userInfo) async {
    _isAuthenticated = true;
    _userInfo = userInfo;
    notifyListeners();
  }

  logoutUser() async {
    _isAuthenticated = false;
    _userInfo = {};
    notifyListeners();
  }
}
