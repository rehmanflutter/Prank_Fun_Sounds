import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeController extends GetxController {
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;
  bool isRewardedAdLoaded = false;
  bool isRewardedVideoComplete = false;

  // void loadRewardedVideoAd() {
  //   FacebookRewardedVideoAd.loadRewardedVideoAd(
  //     placementId: "1387376528546955", // "876616926981816_876617673648408",
  //     listener: (result, value) {
  //       print("Rewarded Ad: $result --> $value");
  //       if (result == RewardedVideoAdResult.LOADED) isRewardedAdLoaded = true;
  //       if (result == RewardedVideoAdResult.VIDEO_COMPLETE)
  //         isRewardedVideoComplete = true;

  //       /// Once a Rewarded Ad has been closed and becomes invalidated,
  //       /// load a fresh Ad by calling this function.
  //       if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
  //           value["invalidated"] == true) {
  //         isRewardedAdLoaded = false;

  //         loadRewardedVideoAd();
  //       }
  //     },
  //   );
  // }

  // void loadRewardedVideoAd() {
  //   FacebookRewardedVideoAd.loadRewardedVideoAd(
  //     placementId: "876616926981816_876617673648408",
  //     listener: (result, value) {
  //       print("Rewarded Ad: $result --> $value");
  //       if (result == RewardedVideoAdResult.LOADED) {
  //         isRewardedAdLoaded = true;
  //       }
  //       if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
  //         isRewardedVideoComplete = true;
  //         // Navigate to SoundChose screen when the rewarded video is complete
  //         // Note: Replace with your navigation logic or handle it in the UI
  //         // Get.to(SoundChose(
  //         //   index: '${value["placement_id"]}', // Update accordingly
  //         //   soundName: 'YourSoundName', // Update accordingly
  //         // ));
  //       }
  //       if (result == RewardedVideoAdResult.ERROR) {
  //         // Show Snackbar if the rewarded video ad fails to load
  //         Get.snackbar(
  //           "Ad Loading Failed",
  //           "No fill. Please try again later.",
  //           snackPosition: SnackPosition.BOTTOM,
  //           duration: Duration(seconds: 3),
  //         );
  //         // Set isRewardedAdLoaded to false to handle the error
  //         isRewardedAdLoaded = false;
  //       }
  //     },
  //   );
  // }
}
