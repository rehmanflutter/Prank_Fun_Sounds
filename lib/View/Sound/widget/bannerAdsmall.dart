// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'dart:io' show Platform;

// import 'package:sound/Controller/soundController/PlayControl.dart';

// class BannerAdSmall extends StatefulWidget {
//   @override
//   State<BannerAdSmall> createState() => _BannerAdSmallState();
// }

// class _BannerAdSmallState extends State<BannerAdSmall> {
//   final controller = Get.put(PlayController());

//   BannerAd? bannerAd;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     BannerAdListener bannerAdListener = BannerAdListener(
//         onAdWillDismissScreen: (ad) {
//           ad.dispose();
//         },
//         onAdClosed: (ad) {});

//     bannerAd = BannerAd(
//       size: AdSize.banner,
//       adUnitId: Platform.isAndroid
//           ? "ca-app-pub-3940256099942544/6300978111"
//           : "ca-app-pub-3940256099942544/2934735716",
//       listener: BannerAdListener(),
//       request: const AdRequest(),
//     );
//     bannerAd!.load().catchError((e) {
//       controller.adHaveError.value = true;
//     });
//     ;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       child: AdWidget(ad: bannerAd!),
//     );
//   }
// }

//}

import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;

import 'package:sound/Controller/soundController/PlayControl.dart';

class BannerAdSmall extends StatefulWidget {
  @override
  State<BannerAdSmall> createState() => _BannerAdSmallState();
}

class _BannerAdSmallState extends State<BannerAdSmall> {
  final controller = Get.put(PlayController());

  BannerAd? facebookBannerAd;
  BannerAd? googleBannerAd;

  @override
  void initState() {
    super.initState();

    // Initialize Facebook Audience Network
    FacebookAudienceNetwork.init(
      testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
      iOSAdvertiserTrackingEnabled: true, //default false
    );

    // Load Facebook Banner Ad
    final facebookBannerAd = FacebookBannerAd(
      placementId: Platform.isAndroid
          ? controller.settingModel!.facebookBannerAdId
          : "YOUR_IOS_PLACEMENT_ID",
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        switch (result) {
          case BannerAdResult.ERROR:
            _loadGoogleAd();

            break;
          case BannerAdResult.LOADED:
            print("Facebook Banner Ad Loaded");
            break;
          case BannerAdResult.CLICKED:
            print("Banner Ad Clicked!"); // Handle banner ad click event
            break;
          case BannerAdResult.LOGGING_IMPRESSION:
            print("Logging Impression: $value");
            break;
          default:
            // Handle any unhandled cases
            print("Unhandled result: $result");
        }
      },
    );

    // Load Google Banner Ad in the background (as a fallback)
    _loadGoogleAd();
  }

  void _loadGoogleAd() async {
    googleBannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid
          ? controller.settingModel!.googleBannerAdId
          : "ca-app-pub-3940256099942544/2934735716",
      listener: BannerAdListener(),
      request: const AdRequest(),
    );
    await googleBannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: facebookBannerAd != null
          ? facebookBannerAd as Widget // Cast as Widget
          : googleBannerAd != null
              ? AdWidget(ad: googleBannerAd!)
              : Container(), // Show a placeholder while ads load
    );
  }
}
