import 'package:flutter/material.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/theme.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);

    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Dark Theme'),
          contentPadding: const EdgeInsets.only(left: 16.0),
          trailing: Transform.scale(
            scale: 0.4,
            child: DayNightSwitch(
              value: _darkTheme,
              onChanged: (val) {
                setState(() {
                  _darkTheme = val;
                });
                onThemeChanged(val, themeNotifier);
              },
            ),
          ),
        )
      ],
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
