import 'dart:io' show Platform;

class AdsManager {
  static const bool _testMode = true;

  // ------------------ banner ---------------------

  static String get bannerAdUnitID {
    if (_testMode) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-8654666918240863/7501398769';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-8654666918240863/4243899780';
      }
    }
    return '';
  }

  // ------------------ interstitial---------------------
  static String get interstitialAdUnitID {
    if (_testMode) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-8654666918240863/1786037657';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-8654666918240863/1326377819';
      }
    }
    return '';
  }

  // ------------------ native ---------------------

  static String get nativeAdUnitID {
    if (_testMode) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-8654666918240863/5533710979';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-8654666918240863/9372388790';
      }
    }
    return '';
  }
}
