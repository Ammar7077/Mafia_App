import 'package:flutter/material.dart';
import 'package:mafia_app/providers/provider.dart';
import 'package:mafia_app/screens/page2.dart';
import 'package:mafia_app/shared/components.dart';
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("مافيا"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(15.0),
          itemCount: provider.roles.length,
          itemBuilder: (context, index) => index + 1 == provider.roles.length
              ? textField(provider.roleController, provider)
              : role(provider.roles.keys.toList()[index + 1],
                  provider.roles.values.toList()[index + 1], provider)),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              provider.roles.forEach((key, value) => provider.list.add({key:value}));
              provider.list.shuffle();
              navigateToReplacement(context, const Page2());
            },
            child: const Text("بدء اللعبة", style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }
}
