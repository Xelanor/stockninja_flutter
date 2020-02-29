import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../widgets/auth/user_first_input.dart';
import '../providers/authentication.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Timer _timer;
  // int _start = 120;

  void _showlogoutDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text("StockNinja'dan çıkış yapmak istiyor musunuz?"),
          actions: <Widget>[
            RaisedButton(
              color: Theme.of(context).colorScheme.primary,
              child: Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Çıkış Yap"),
              onPressed: () {
                logoutUser();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void logoutUser() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('jwtToken');
    Provider.of<AuthNotifier>(context, listen: false).logoutUser();
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
    return Consumer<AuthNotifier>(
      builder: (context, auth, child) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text(
                  '',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: Theme.of(context).colorScheme.background,
                brightness: Theme.of(context).brightness,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 22),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Profil',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            ButtonTheme(
                              minWidth: 200,
                              child: RaisedButton(
                                onPressed: () {
                                  auth.getUserAuthState
                                      ? _showlogoutDialog()
                                      : Navigator.of(context).push(
                                          new MaterialPageRoute<Null>(
                                            builder: (BuildContext context) {
                                              return UserFirstInput();
                                            },
                                            fullscreenDialog: true,
                                          ),
                                        );
                                },
                                color: auth.getUserAuthState
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primaryVariant
                                    : Theme.of(context).colorScheme.primary,
                                child: Text(
                                  auth.getUserAuthState
                                      ? 'Çıkış Yap'
                                      : 'Giriş / Kayıt',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 100,
                          child: Image.asset(
                            "assets/images/ninja.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
