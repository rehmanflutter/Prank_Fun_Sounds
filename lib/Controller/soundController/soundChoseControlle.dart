import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;

import 'package:sound/utils/Appcustom.dart';

class SoundChoseController extends GetxController {
  RxBool buttontab = true.obs;
  RewardedAd? rewardedAd;
  bool isRewardedAdLoaded = false;
  bool isRewardedVideoComplete = false;

  /// BAnner addd
  ///
  ///
  Widget getAd() {
    BannerAdListener bannerAdListener =
        BannerAdListener(onAdWillDismissScreen: (ad) {
      ad.dispose();
    }, onAdClosed: (ad) {
      debugPrint("Ad Got Closeed");
    });
    BannerAd bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-3940256099942544/6300978111"
          : "ca-app-pub-3940256099942544/2934735716",
      listener: bannerAdListener,
      request: const AdRequest(),
    );

    bannerAd.load();

    return Container(
      color: backcol,
      height: 50,
      child: AdWidget(ad: bannerAd),
    );
  }
}
