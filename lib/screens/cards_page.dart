import 'dart:developer';
import 'package:Mafia/providers/provider.dart';
import 'package:Mafia/shared/ads-manager.dart';
import 'package:Mafia/shared/components.dart';
import 'package:Mafia/shared/mafia_card.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

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

    return Scaffold(
      backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/Mafia_Logo.png',
            fit: BoxFit.fill, height: getHeight(context) * 0.055),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              !provider.isCardHidden
                  ? Text(
                      'لا تنسى رقمك ${provider.index + 1} / ${provider.list.length}',
                      style: TextStyle(
                          fontSize: getWidth(context) * 0.06,
                          color: provider.index != provider.list.length - 1
                              ? Colors.white
                              : const Color.fromRGBO(200, 15, 15, 1),
                          fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(),
              Text(
                provider.index != provider.list.length - 1
                    ? 'اكبس التالي بعد ما تقلبها'
                    : provider.isCardHidden && !provider.isEndTheGame
                        ? 'وقت التصويت'
                        : provider.isCardHidden && provider.isEndTheGame
                            ? 'بتمنى لعبتوها بذكاء'
                            : 'انتهى العدد، إخفي بطاقتك',
                style: TextStyle(
                    fontSize: getWidth(context) * 0.06,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: !provider.isCardHidden
                    ? MafiaCard(
                        name: provider.list[provider.index],
                      )
                    : !provider.isEndTheGame
                        ? InkWell(
                            onTap: () => provider.timerClicked(),
                            child: countDownTimer(context, provider),
                          )
                        : listViewCardsPage(
                            context, provider, getWidth(context) * 0.042),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: TextButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all(provider.isCardFlipped
                              ? provider.index == provider.list.length - 1
                                  ? const Color.fromRGBO(203, 15, 15, 1)
                                  : Colors.black
                              : Colors.grey)),
                  onPressed: () {
                    if (provider.isEndTheGame && provider.isCardHidden) {
                      // Dialog();
                      navigateToReplacement(context, const MyHomePage());
                      provider.callback = false;
                      provider.index = 0;
                      provider.isEndTheGame = false;
                      provider.isCardHidden = false;
                      provider.list.clear();
                      provider.roles = {
                        '_': 0,
                        'مافيا': 2,
                        'زعيم المافيا': 0,
                        'مواطن': 4,
                        'زعيم المواطنين': 1,
                        'دكتور': 0,
                        'قاتل متسلسل': 0,
                        'محقق': 0,
                      };
                    } else if (provider.isCardFlipped) {
                      provider.onPressed();
                    }

                    // log('message:: ${provider.list[provider.index]}');
                    // log('index: ${provider.index}');
                    log(':::card: ${provider.isCardHidden}');
                    log(':end: ${provider.isEndTheGame}');
                  },
                  child: provider.index != provider.list.length - 1
                      ? Text(
                          "التالي",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getWidth(context) * 0.04,
                              fontWeight: FontWeight.bold),
                        )
                      : provider.isEndTheGame && provider.isCardHidden
                          ? Text("العوده للصفحة الرئيسية",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getWidth(context) * 0.04,
                                  fontWeight: FontWeight.bold))
                          : provider.isCardHidden
                              ? Text("إظهار البطاقات | إنهاء اللعبة",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getWidth(context) * 0.04,
                                      fontWeight: FontWeight.bold))
                              : Text("إخفاء البطاقات",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getWidth(context) * 0.04,
                                      fontWeight: FontWeight.bold)),
                ),
              ),
              // Icon(Icons.fast_forward_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
