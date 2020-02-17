import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../widgets/auth/user_first_input.dart';
import '../widgets/auth/user_second_input.dart';
import '../providers/authentication.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _passCodePage = false;
  var _email = "";
  var _userInfo;
  var _isAuthenticated;

  // Timer _timer;
  // int _start = 120;

  void initialRegister(email) {
    const url = 'http://10.0.2.2:5000/api/auth/signup';
    http.post(
      url,
      body: json.encode({'email': email}),
      headers: {"Content-Type": "application/json"},
    ).then((res) {
      if (res.statusCode == 200) {
        setState(() {
          _passCodePage = true;
          _email = email;
        });
      }
    });
  }

  void passLogin(String email, String code) {
    var url = 'http://10.0.2.2:5000/api/auth/login/$code';
    http.post(
      url,
      body: json.encode({'email': email}),
      headers: {"Content-Type": "application/json"},
    ).then((res) async {
      if (res.statusCode == 200) {
        var prefs = await SharedPreferences.getInstance();
        var token = json.decode(res.body)['token'];
        prefs.setString('jwtToken', token);
        setState(() {
          _passCodePage = false;
        });
      }
    });
  }

  // void startTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) => setState(
  //       () {
  //         if (_start < 1) {
  //           timer.cancel();
  //           _passCodePage = false;
  //         } else {
  //           _start = _start - 1;
  //         }
  //       },
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    _userInfo = (authNotifier.getUserInfo());
    _isAuthenticated = (authNotifier.getUserAuthState());
    return Column(
      children: <Widget>[
        AppBar(
          title: Text(
            _isAuthenticated
                ? json.decode(_userInfo['identity'])['email']
                : "Not Authenticated",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          brightness: Theme.of(context).brightness,
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: 300,
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryVariant,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: !_passCodePage
                ? UserFirstInput(initialRegister)
                : UserSecondInput(passLogin, _email),
          ),
        ),
      ],
    );
  }
}
