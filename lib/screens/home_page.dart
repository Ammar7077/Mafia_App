import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mafia_app/screens/page2.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';
import '../shared/components.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/Mafia_Logo.png',
            fit: BoxFit.fill, height: height * 0.06),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(15.0),
                itemCount: provider.roles.length,
                itemBuilder: (context, index) =>
                    index + 1 == provider.roles.length
                        ? textField(context, provider.roleController, provider)
                        : role(
                            provider.roles.keys.toList()[index + 1],
                            provider.roles.values.toList()[index + 1],
                            provider,
                            width * 0.043)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(203, 15, 15, 1))),
                  onPressed: () {
                    provider.isCardFlipped = false;
                    provider.roles.remove('_');
                    provider.roles.forEach((key, value) {
                      for (int i = 0; i < value; ++i) {
                        provider.list.add(key);
                      }
                    });
                    log('${provider.list}');
                    provider.list.shuffle();
                    navigateToReplacement(context, Page2());
                  },
                  child: const Text("بدء اللعبة",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
