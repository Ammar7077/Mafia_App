import 'package:Mafia/shared/ads-manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsProvider extends ChangeNotifier {
  //------------------- banner
  late BannerAd bannerAd;
  bool isBannerAdLoaded = false;
  createBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdsManager.bannerAdUnitID,
        listener: BannerAdListener(onAdLoaded: (ad) => isBannerAdLoaded = true),
        request: const AdRequest());
    bannerAd.load();
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }

  // --------------------Interstitial

  createInterstitialAd() {}
}
