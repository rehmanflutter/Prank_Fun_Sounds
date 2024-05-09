import 'package:cloud_firestore/cloud_firestore.dart';

class SettingModel {
  bool backButtonAd;
  String playButtonText;
  String secondaryButtonText;
  String facebookBannerAdId;
  String facebookPlacementId;
  String googleBannerAdId;
  String googleRewardedAd;
  String googelFulScreenBannerAd;

  SettingModel(
      {required this.backButtonAd,
      required this.playButtonText,
      required this.secondaryButtonText,
      required this.facebookBannerAdId,
      required this.facebookPlacementId,
      required this.googleBannerAdId,
      required this.googleRewardedAd,
      required this.googelFulScreenBannerAd});

  Map<String, dynamic> jason() => {
        "backButtonAd": backButtonAd,
        "playButtonText": playButtonText,
        "secondaryButtonText": secondaryButtonText,
        "facebookBannerAdId": facebookBannerAdId,
        "facebookPlacementId": facebookPlacementId,
        "googleBannerAdId": googleBannerAdId,
        "googleRewardedAd": googleRewardedAd,
        "googelFulScreenBannerAd": googelFulScreenBannerAd
      };
  static SettingModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return SettingModel(
        backButtonAd: snapshot['backButtonAd'],
        playButtonText: snapshot['playButtonText'],
        secondaryButtonText: snapshot['secondaryButtonText'],
        facebookBannerAdId: snapshot["facebookBannerAdId"],
        facebookPlacementId: snapshot["facebookPlacementId"],
        googleBannerAdId: snapshot["googleBannerAdId"],
        googleRewardedAd: snapshot["googleRewardedAd"],
        googelFulScreenBannerAd: snapshot["googelFulScreenBannerAd"]);
  }
}
