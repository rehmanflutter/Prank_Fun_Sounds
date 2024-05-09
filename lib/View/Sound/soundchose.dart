import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_audience_network/ad/ad_rewarded.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound/Controller/soundController/PlayControl.dart';
import 'package:sound/Controller/soundController/soundChoseControlle.dart';
import 'package:sound/View/Sound/playsound.dart';
import 'package:sound/View/Sound/widget/backButton.dart';
import 'package:sound/View/Sound/widget/bannerAdsmall.dart';
import 'package:sound/utils/Appcustom.dart';
import 'package:sound/utils/custom/colContainer.dart';
import 'package:sound/utils/custom/textcustam.dart';
import 'dart:io' show Platform;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SoundChose extends StatefulWidget {
  String index;
  String soundName;
  SoundChose({required this.index, required this.soundName});

  @override
  State<SoundChose> createState() => _SoundChoseState();
}

class _SoundChoseState extends State<SoundChose> {
  final controller = Get.put(SoundChoseController());
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;
  final playcontroller = Get.put(PlayController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playcontroller.setting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backcol,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButtonCustam(),
                Textcustom(
                  text: widget.soundName,
                  size: 20,
                  weight: FontWeight.w700,
                  col: white,
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 6,
            //     right: 6,
            //     top: 15,
            //   ),
            //   child: SizedBox(
            //       //  color: Colors.amber,
            //       height: 100,
            //       child: AdWidget(ad: bannerAd!)),
            // ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Sound")
                  .doc('${widget.index}')
                  .collection("sound")
                  .snapshots(),
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
                    child: CircularProgressIndicator(),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      String images =
                          snapshot.data!.docs[index]["networkImage"];
                      //  String name = snapshot.data!.docs[index]['soundName'];
                      String Sound = snapshot.data!.docs[index]["sound"];
                      String link = snapshot.data!.docs[index]["link"];
                      String check = snapshot.data!.docs[index]["check"];
                      Color colors =
                          Colors.blue; //snapshot.data!.docs[index]["color"];
                      String modelText =
                          snapshot.data!.docs[index]["modelText"];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 10.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (controller.buttontab.value == true) {
                                  controller.buttontab.value = false;

                                  FacebookRewardedVideoAd.loadRewardedVideoAd(
                                    placementId: playcontroller
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
                                        Get.to(PlaySound(
                                          image: images,
                                          name: '${widget.soundName}',
                                          sound: Sound,
                                          link: link,
                                          check: check,
                                          col: colors,
                                          index: '${index + 1}',
                                          modelText: modelText,
                                        ));
//
                                        controller.buttontab.value = true;
///////
                                        controller.buttontab.value = true;
                                      }
                                      if (result ==
                                          RewardedVideoAdResult.ERROR) {
                                        // Show Snackbar if the rewarded video ad fails to load

                                        RewardedAd.load(
                                          adUnitId: Platform.isAndroid
                                              ? playcontroller.settingModel!
                                                  .googleRewardedAd
                                              : "ca-app-pub-3940256099942544/6978759866",
                                          request: const AdRequest(),
                                          rewardedAdLoadCallback:
                                              RewardedAdLoadCallback(
                                            onAdLoaded: (ad) {
                                              rewardedAd = ad;
                                              rewardedAd?.show(
                                                onUserEarnedReward:
                                                    ((ad, reward) {
                                                  debugPrint(
                                                      "My Reward Amount -> ${reward.amount}");
                                                }),
                                              );

                                              rewardedAd
                                                      ?.fullScreenContentCallback =
                                                  FullScreenContentCallback(
                                                      onAdFailedToShowFullScreenContent:
                                                          (ad, err) {
                                                ad.dispose();
                                              }, onAdDismissedFullScreenContent:
                                                          (ad) {
                                                ad.dispose();
                                                Get.to(PlaySound(
                                                  image: images,
                                                  name: '${widget.soundName}',
                                                  sound: Sound,
                                                  link: link,
                                                  check: check,
                                                  col: colors,
                                                  index: '${index + 1}',
                                                  modelText: modelText,
                                                ));
//
                                                controller.buttontab.value =
                                                    true;
                                              });
                                            },
                                            onAdFailedToLoad: (err) {
                                              InterstitialAd.load(
                                                  adUnitId: Platform.isAndroid
                                                      ? playcontroller
                                                          .settingModel!
                                                          .googelFulScreenBannerAd
                                                      : 'ca-app-pub-3940256099942544/2934735716',
                                                  request: AdRequest(),
                                                  adLoadCallback:
                                                      InterstitialAdLoadCallback(
                                                    onAdLoaded: (ad) {
                                                      interstitialAd = ad;
                                                      interstitialAd!.show();
                                                      interstitialAd!
                                                              .fullScreenContentCallback =
                                                          FullScreenContentCallback(
                                                        onAdFailedToShowFullScreenContent:
                                                            (ad, error) {
                                                          ad.dispose();
                                                          interstitialAd!
                                                              .dispose();
                                                        },
                                                        onAdDismissedFullScreenContent:
                                                            (ad) {
                                                          ad.dispose();
                                                          interstitialAd!
                                                              .dispose();

                                                          Get.to(PlaySound(
                                                            image: images,
                                                            name:
                                                                '${widget.soundName}',
                                                            sound: Sound,
                                                            link: link,
                                                            check: check,
                                                            col: colors,
                                                            index:
                                                                '${index + 1}',
                                                            modelText:
                                                                modelText,
                                                          ));
                                                          controller.buttontab
                                                              .value = true;

                                                          ///
                                                        },
                                                      );
                                                    },
                                                    onAdFailedToLoad: (error) {
                                                      Get.to(PlaySound(
                                                        image: images,
                                                        name:
                                                            '${widget.soundName}',
                                                        sound: Sound,
                                                        link: link,
                                                        check: check,
                                                        col: colors,
                                                        index: '${index + 1}',
                                                        modelText: modelText,
                                                      ));

                                                      ///
                                                      controller.buttontab
                                                          .value = true;
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
                              },
                              child: ColContainer(
                                Col: Colors.blue,
                                wigth: 350,
                                hight: 97,
                                cir: 10,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 5),
                                      child: ImageContainer(
                                          wigth: 48, hight: 48, image: images),
                                    ),
                                    Container(
                                      width: 175,
                                      // color: Colors.red,
                                      child: Textcustom(
                                        maxline: true,
                                        text:
                                            '${widget.soundName} ${index + 1}',
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
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //     left: 6,
                            //     right: 6,
                            //     top: 15,
                            //   ),
                            //   child: SizedBox(
                            //       //  color: Colors.amber,
                            //       height: 100,
                            //       child: AdWidget(ad: bannerAd!)),
                            // ),
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
