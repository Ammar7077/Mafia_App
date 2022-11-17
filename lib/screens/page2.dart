import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../providers/provider.dart';
import '../shared/ads-manager.dart';
import '../shared/components.dart';
import 'MafiaCard.dart';
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

    listView(txtSize) => ListView.builder(
          itemCount: provider.list.length,
          itemBuilder: (context, i) => Card(
            color: provider.list[i] == "مافيا" ||
                    provider.list[i] == "زعيم المافيا"
                ? Colors.black
                : Colors.white70,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '${i + 1}  ${provider.list[i]}',
                style: TextStyle(
                    color: provider.list[i] == "مافيا" ||
                            provider.list[i] == "زعيم المافيا"
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: txtSize),
              ),
            )),
          ),
        );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/Mafia_Logo.png',
            fit: BoxFit.fill, height: height * 0.055),
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
                height: height * 0.02,
              ),
              Text(
                !provider.isCardHidden
                    ? 'لا تنسى رقمك ${provider.index + 1} / ${provider.list.length}'
                    : '',
                style: TextStyle(
                    fontSize: width * 0.06,
                    color: provider.index != provider.list.length - 1
                        ? Colors.white
                        : const Color.fromRGBO(200, 15, 15, 1),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                provider.index != provider.list.length - 1
                    ? 'اكبس التالي بعد ما تقلبها'
                    : provider.isCardHidden && !provider.isEndTheGame
                        ? 'وقت التصويت'
                        : provider.isCardHidden && provider.isEndTheGame
                            ? 'بتمنى لعبتوها بذكاء'
                            : 'انتهى العدد، إخفي بطاقتك',
                style: TextStyle(
                    fontSize: width * 0.06,
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
                            child: CircularCountDownTimer(
                              // Countdown duration in Seconds.
                              duration: provider.duration,

                              // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
                              controller: provider.timerController,

                              // Width of the Countdown Widget.
                              width: width / 2,

                              // Height of the Countdown Widget.
                              height: height / 2,

                              // Ring Color for Countdown Widget.
                              ringColor: Colors.white,
                              // Filling Color for Countdown Widget.
                              fillColor: const Color.fromRGBO(200, 15, 15, 1),
                              // Background Color for Countdown Widget.
                              backgroundColor: Colors.black,

                              // Border Thickness of the Countdown Ring.
                              strokeWidth: 20.0,

                              // Begin and end contours with a flat edge and no extension.
                              strokeCap: StrokeCap.round,

                              // Text Style for Countdown Text.
                              textStyle: TextStyle(
                                fontSize: width * 0.07,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),

                              // Format for the Countdown Text.
                              textFormat: CountdownTextFormat.S,

                              // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
                              isReverse: false,

                              // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
                              isReverseAnimation: false,

                              // Handles visibility of the Countdown Text.
                              isTimerTextShown: true,

                              // Handles the timer start.
                              autoStart: false,

                              // This Callback will execute when the Countdown Ends.
                              onComplete: () {
                                provider.isTimeComplete =
                                    !provider.isTimeComplete;
                                provider.isTimeComplete
                                    ? ''
                                    : Alert(
                                            context: context,
                                            title: 'انتهى الوقت',
                                            style: AlertStyle(
                                              isCloseButton: true,
                                              isButtonVisible: false,
                                              titleStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 30.0,
                                              ),
                                            ),
                                            type: AlertType.success)
                                        .show();
                                provider.isPause = true;
                                provider.timerController.reset();
                              },

                              // This Callback will execute when the Countdown Changes.
                              onChange: (String timeStamp) {
                                // Here, do whatever you want
                                debugPrint('Countdown Changed $timeStamp');
                              },
                              timeFormatterFunction:
                                  (defaultFormatterFunction, duration) {
                                if (duration.inSeconds == 0) {
                                  // only format for '0'
                                  return "Start";
                                } else {
                                  // other durations by it's default format
                                  return Function.apply(
                                      defaultFormatterFunction, [duration]);
                                }
                              },
                            ),
                          )
                        : listView(width * 0.042),
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
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold),
                        )
                      : provider.isEndTheGame && provider.isCardHidden
                          ? Text("العوده للصفحة الرئيسية",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold))
                          : provider.isCardHidden
                              ? Text("إظهار البطاقات | إنهاء اللعبة",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.bold))
                              : Text("إخفاء البطاقات",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.04,
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
