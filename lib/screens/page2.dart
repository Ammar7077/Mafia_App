import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mafia_app/providers/provider.dart';
import 'package:mafia_app/screens/home_page.dart';
import 'package:mafia_app/shared/ads-manager.dart';
import 'package:mafia_app/shared/components.dart';
import 'package:provider/provider.dart';

class Page2 extends StatelessWidget {
  Page2({Key? key}) : super(key: key) {
    _initAd();
  }

  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdLoaded = false;

  void _initAd() {
    InterstitialAd.load(
        adUnitId: AdsManager.interstitialAdUnitID,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: onAdLoaded, onAdFailedToLoad: (err) {}));
  }

  void onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isInterstitialAdLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    listView() => ListView.builder(
          itemCount: provider.list.length,
          itemBuilder: (context, i) => Card(
            color: Colors.white,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('${provider.list[i]}'),
            )),
          ),
        );
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('${provider.index + 1} / ${provider.list.length}'),
          Expanded(
            child: !provider.isEndTheGame
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text('${provider.list[provider.index]}'),
                  ))
                : listView(),
          ),
          TextButton(
            onPressed: () {
              if (!provider.isEndTheGame) {
                provider.onPressed();
              } else {
                navigateToReplacement(context, MyHomePage());
                provider.index = 0;
                provider.isEndTheGame = false;
                provider.list.clear();
                if (_isInterstitialAdLoaded)
                  {
                    _interstitialAd.show();
                  }
              }
            },
            child: provider.index + 1 != provider.list.length
                ? const Text("إظهار")
                : provider.isEndTheGame
                    ? const Text("العوده للصفحة الرئيسية")
                    : const Text("إنهاء اللعبة"),
          )
        ],
      ),
    );
  }
}
