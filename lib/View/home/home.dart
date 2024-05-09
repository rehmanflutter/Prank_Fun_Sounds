import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound/Controller/homecon.dart';
import 'package:sound/Controller/soundController/PlayControl.dart';
import 'package:sound/View/Sound/soundchose.dart';
import 'package:sound/View/Sound/widget/bannerAdsmall.dart';
import 'package:sound/utils/Appcustom.dart';
import 'package:sound/utils/custom/colContainer.dart';
import 'package:sound/utils/custom/textcustam.dart';
import 'package:sound/utils/imagess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io' show Platform;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool buttontab = true;

  final controller = Get.put(HomeController());
  final settingcon = Get.put(PlayController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingcon.setting();
    FacebookAudienceNetwork.init(
      testingId: "35e92a63-8102-46a4-b0f5-4fd269e6a13c",
    );
    //  controller.loadRewardedVideoAd();
  }

  // Widget _currentAd = SizedBox(
  //   width: 0.0,
  //   height: 0.0,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backcol,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 190,
                  //color: white,
                  child: Textcustom(
                    text: 'Air Horn Prank Fun Sounds',
                    size: 18,
                    col: white,
                    weight: FontWeight.w600,
                  ),
                ),
                ColContainer(
                  wigth: 50,
                  Col: Orange,
                  hight: 50,
                  cir: 10,
                  child: Center(child: Image.asset(Images.lack)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("Sound").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('An Error');
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: SizedBox(),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      String images =
                          snapshot.data!.docs[index]["networkImage"];
                      String Soundname =
                          snapshot.data!.docs[index]['soundName'];
                      //String colors = snapshot.data!.docs[index]['color'];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 10.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // controller.loadRewardedVideoAd();
                                // if (controller.isRewardedAdLoaded == true) {
                                //   FacebookRewardedVideoAd.showRewardedVideoAd();
                                // } else {
                                //   print("Rewarded Ad not yet loaded!");
                                // }

                                if (buttontab == true) {
                                  buttontab = false;

                                  FacebookRewardedVideoAd.loadRewardedVideoAd(
                                    placementId: settingcon
                                        .settingModel!.facebookPlacementId,
                                    listener: (result, value) {
                                      print("Rewarded Ad: $result --> $value");
                                      if (result ==
                                          RewardedVideoAdResult.LOADED) {
                                        controller.isRewardedAdLoaded = true;
                                      }
                                      if (result ==
                                          RewardedVideoAdResult
                                              .VIDEO_COMPLETE) {
                                        controller.isRewardedVideoComplete =
                                            true;
                                        // Navigate to SoundChose screen when the rewarded video is complete
                                        // Note: Replace with your navigation logic or handle it in the UI
                                        Get.to(SoundChose(
                                          index:
                                              '${snapshot.data!.docs[index].id}',
                                          soundName: Soundname,
                                        ));
///////
                                        buttontab = true;
                                      }
                                      if (result ==
                                          RewardedVideoAdResult.ERROR) {
                                        // Show Snackbar if the rewarded video ad fails to load

                                        RewardedAd.load(
                                          adUnitId: Platform.isAndroid
                                              ? settingcon.settingModel!
                                                  .googleRewardedAd
                                              : "ca-app-pub-3940256099942544/6978759866",
                                          request: const AdRequest(),
                                          rewardedAdLoadCallback:
                                              RewardedAdLoadCallback(
                                            onAdLoaded: (ad) {
                                              controller.rewardedAd = ad;
                                              controller.rewardedAd?.show(
                                                onUserEarnedReward:
                                                    ((ad, reward) {
                                                  debugPrint(
                                                      "My Reward Amount -> ${reward.amount}");
                                                }),
                                              );

                                              controller.rewardedAd
                                                      ?.fullScreenContentCallback =
                                                  FullScreenContentCallback(
                                                      onAdFailedToShowFullScreenContent:
                                                          (ad, err) {
                                                ad.dispose();
                                              }, onAdDismissedFullScreenContent:
                                                          (ad) {
                                                ad.dispose();
                                                Get.to(SoundChose(
                                                  index:
                                                      '${snapshot.data!.docs[index].id}',
                                                  soundName: Soundname,
                                                ));
                                                ///////
                                                buttontab = true;
                                              });
                                            },
                                            onAdFailedToLoad: (err) {
                                              InterstitialAd.load(
                                                  adUnitId: Platform.isAndroid
                                                      ? settingcon.settingModel!
                                                          .googelFulScreenBannerAd
                                                      : 'ca-app-pub-3940256099942544/2934735716',
                                                  request: AdRequest(),
                                                  adLoadCallback:
                                                      InterstitialAdLoadCallback(
                                                    onAdLoaded: (ad) {
                                                      controller
                                                          .interstitialAd = ad;
                                                      controller.interstitialAd!
                                                          .show();
                                                      controller.interstitialAd!
                                                              .fullScreenContentCallback =
                                                          FullScreenContentCallback(
                                                        onAdFailedToShowFullScreenContent:
                                                            (ad, error) {
                                                          ad.dispose();
                                                          controller
                                                              .interstitialAd!
                                                              .dispose();
                                                        },
                                                        onAdDismissedFullScreenContent:
                                                            (ad) {
                                                          ad.dispose();
                                                          controller
                                                              .interstitialAd!
                                                              .dispose();

                                                          Get.to(SoundChose(
                                                            index:
                                                                '${snapshot.data!.docs[index].id}',
                                                            soundName:
                                                                Soundname,
                                                          ));
///////
                                                          buttontab = true;
                                                        },
                                                      );
                                                    },
                                                    onAdFailedToLoad: (error) {
                                                      Get.to(SoundChose(
                                                        index:
                                                            '${snapshot.data!.docs[index].id}',
                                                        soundName: Soundname,
                                                      ));

                                                      ///
                                                      buttontab = true;
                                                    },
                                                  ));

                                              debugPrint(err.message);
                                            },
                                          ),
                                        );

                                        // Set isRewardedAdLoaded to false to handle the error
                                        controller.isRewardedAdLoaded = false;
                                      }
                                    },
                                  );
                                }

                                // Video Add Show
//
                              },
                              child: ColContainer(
                                wigth: 350,
                                hight: 200,
                                cir: 15,
                                Col: Colors.blue.shade200,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      child: ImageContainer(
                                          wigth: 135,
                                          hight: 135,
                                          image: images),
                                    ),
                                    Container(
                                      width: 125,
                                      // color: Colors.red,
                                      child: Textcustom(
                                        maxline: true,
                                        text:
                                            Soundname, // controller.list[index].text,
                                        size: 20,
                                        col: white,
                                        weight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                  left: 6,
                                  right: 6,
                                  top: 15,
                                ),
                                child: BannerAdSmall() //controller.getAd(),
                                )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
