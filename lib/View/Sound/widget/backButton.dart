import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound/Controller/soundController/PlayControl.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sound/utils/Appcustom.dart';
import 'package:sound/utils/custom/colContainer.dart';
import 'package:sound/utils/imagess.dart';
import 'dart:io' show Platform;

class BackButtonCustam extends StatelessWidget {
  final controller = Get.put(PlayController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.settingModel?.backButtonAd == true) {
          if (controller.backbtn.value == true) {
            controller.backbtn.value = false;
            InterstitialAd.load(
                adUnitId: Platform.isAndroid
                    ? controller.settingModel!.googelFulScreenBannerAd
                    : 'ca-app-pub-3940256099942544/2934735716',
                request: AdRequest(),
                adLoadCallback: InterstitialAdLoadCallback(
                  onAdLoaded: (ad) {
                    controller.interstitialAd = ad;
                    controller.interstitialAd!.show();
                    controller.interstitialAd!.fullScreenContentCallback =
                        FullScreenContentCallback(
                      onAdFailedToShowFullScreenContent: (ad, error) {
                        //    ad.dispose();
                        controller.interstitialAd!.dispose();
                      },
                      onAdDismissedFullScreenContent: (ad) {
                        //    ad.dispose();
                        controller.interstitialAd!.dispose();
                        controller.backbtn.value = true;
                        Get.back();
                      },
                    );
                  },
                  onAdFailedToLoad: (error) {
                    controller.backbtn.value = true;

                    Get.back();
                  },
                ));
          }
        } else {
          Get.back();
        }
      },
      child: ColContainer(
        wigth: 50,
        hight: 50,
        Col: Orange,
        cir: 10,
        child: Center(child: Image.asset(Images.backIcon)),
      ),
    );
  }
}
