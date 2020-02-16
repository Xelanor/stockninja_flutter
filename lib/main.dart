import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './utils/theme.dart';
import './utils/preferences.dart';

import './screens/tabs_screen.dart';
import './screens/homepage_screen.dart';
import './screens/investments_screen.dart';
import './screens/global_screen.dart';
import './screens/search_screen.dart';
import './screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('darkMode') ?? true;
      var graphPeriod = prefs.getInt('graphPeriod') ?? 30;
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeNotifier>(
              create: (ctx) =>
                  ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
            ),
            ChangeNotifierProvider<GraphNotifier>(
              create: (ctx) => GraphNotifier(graphPeriod),
            )
          ],
          child: MyApp(),
        ),
      );
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'StockNinja',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(),
        HomepageScreen.routeName: (ctx) => HomepageScreen(),
        InvestmentsScreen.routeName: (ctx) => InvestmentsScreen(),
        SearchScreen.routeName: (ctx) => SearchScreen(),
        GlobalScreen.routeName: (ctx) => GlobalScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
      },
    );
  }
}
