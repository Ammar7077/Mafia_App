import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mafia_app/providers/ads-provider.dart';
import 'package:mafia_app/screens/page2.dart';
import 'package:mafia_app/shared/ads-manager.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';
import '../shared/components.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    Provider.of<AdsProvider>(context,listen: false).createBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    AdsProvider adsProvider = Provider.of<AdsProvider>(context);
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
              provider.roles.remove('_');
              provider.roles.forEach((key, value) {
                for (int i = 0; i < value; ++i) {
                  provider.list.add(key);
                }
              });
              print(provider.list);
              provider.list.shuffle();
              navigateToReplacement(context, Page2());
            },
            child: const Text("بدء اللعبة", style: TextStyle(fontSize: 18)),
          )
        ],
      ),
      bottomNavigationBar: adsProvider.isBannerAdLoaded
          ? SizedBox(
              height: adsProvider.bannerAd.size.height.toDouble(),
              width: adsProvider.bannerAd.size.width.toDouble(),
              child: AdWidget(
                ad: adsProvider.bannerAd,
              ),
            )
          : const SizedBox(),
    );
  }
}
