import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mafia_app/providers/ads-provider.dart';
import 'package:mafia_app/providers/provider.dart';
import 'package:mafia_app/screens/home_page.dart';
import 'package:mafia_app/shared/themes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyProvider>(
          create: (_) => MyProvider(),
        ),
        ChangeNotifierProvider<AdsProvider>(
          create: (_) => AdsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme(),
        themeMode: ThemeMode.dark,
        home: MyHomePage(),
      ),
    );
  }
}
