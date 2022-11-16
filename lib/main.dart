import 'package:flutter/material.dart';
import 'package:mafia_app/providers/provider.dart';
import 'package:mafia_app/screens/home_page.dart';
import 'package:mafia_app/shared/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProvider>(
      create: (BuildContext context) => MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme(),
        themeMode: ThemeMode.dark,
        home: const MyHomePage(),
      ),
    );
  }
}
