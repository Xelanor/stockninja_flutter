import 'package:flutter/material.dart';

class AuthNotifier with ChangeNotifier {
  Map _userInfo;
  bool _isAuthenticated = false;

  AuthNotifier(this._userInfo, this._isAuthenticated);

  getUserInfo() => _userInfo;
  getUserAuthState() => _isAuthenticated;

  setUserInfo(Map userInfo) async {
    _isAuthenticated = true;
    _userInfo = userInfo;
    notifyListeners();
  }
}
