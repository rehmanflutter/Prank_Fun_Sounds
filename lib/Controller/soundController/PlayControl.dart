import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sound/Model/seyttingModel.dart';

// real
class PlayController extends GetxController {
// Banner Faile op
  RxBool adHaveError = false.obs;

// Get Setting
  SettingModel? settingModel;
  Future<SettingModel> setting() async {
    final appsetting = await FirebaseFirestore.instance
        .collection("setting")
        .doc("BjElQLVwXZNhXRRefGgo")
        .get();
    settingModel = SettingModel.fromSnap(appsetting);
    update();

    return settingModel!;
  }

  RxBool buttontab = true.obs;
  RxBool backbtn = true.obs;

  RxBool value = false.obs;
  RxString run = "Play".obs;
  RxBool isPlaying = false.obs;

  InterstitialAd? interstitialAd;
  late AudioPlayer audioPlayer;

  AdRequest? adRequest;
  BannerAd? bannerAd;
  RewardedAd? rewardedAd;

//  PLay Sound

  Future<void> pausePlayback() async {
    if (isPlaying.value) {
      await audioPlayer.pause();
      isPlaying(false);
      run("Play");
    }

    buttontab.value = true;
  }

  Future<void> playRecord(String sound) async {
    try {
      UrlSource urlsource = UrlSource(sound);
      await audioPlayer.play(urlsource);
      isPlaying(true);
      run("Stop");
      buttontab.value = true;
    } catch (e) {}
  }
}
