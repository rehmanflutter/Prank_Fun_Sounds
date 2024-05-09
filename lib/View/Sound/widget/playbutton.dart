import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sound/Controller/soundController/PlayControl.dart';
import 'package:sound/utils/Appcustom.dart';
import 'package:sound/utils/custom/colContainer.dart';
import 'package:sound/utils/custom/textcustam.dart';
import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';

class PlayButton extends StatelessWidget {
  String sound;
  String check;
  String link;
  PlayButton({required this.check, required this.link, required this.sound});

  final controller = Get.put(PlayController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.run.value == 'Stop') {
          controller.buttontab.value = true;
          controller.pausePlayback();
          controller.run("Play");
        } else {
          if (controller.buttontab.value == true) {
            print("Click success");
            controller.buttontab.value = false;

            if (check == "ad") {
              RewardedAd.load(
                adUnitId: Platform.isAndroid
                    ? controller.settingModel!.googleRewardedAd
                    : "ca-app-pub-3940256099942544/6978759866",
                request: const AdRequest(),
                rewardedAdLoadCallback: RewardedAdLoadCallback(
                  onAdLoaded: (ad) {
                    controller.rewardedAd = ad;
                    controller.rewardedAd?.show(
                      onUserEarnedReward: ((ad, reward) {
                        debugPrint("My Reward Amount -> ${reward.amount}");
                      }),
                    );

                    controller.rewardedAd?.fullScreenContentCallback =
                        FullScreenContentCallback(
                            onAdFailedToShowFullScreenContent: (ad, err) {
                      //     ad.dispose();
                    }, onAdDismissedFullScreenContent: (ad) {
                      //   ad.dispose();
                      //  OnTAb only one time
                      controller.buttontab.value = true;

                      if (controller.isPlaying.value) {
                        controller.pausePlayback();
                        controller.run("Play");
                      } else {
                        controller.playRecord(sound);
                        controller.run("Stop");
                      }
                    });
                  },
                  onAdFailedToLoad: (err) {
                    InterstitialAd.load(
                        adUnitId: Platform.isAndroid
                            ? controller.settingModel!.googelFulScreenBannerAd
                            : 'ca-app-pub-3940256099942544/2934735716',
                        request: AdRequest(),
                        adLoadCallback: InterstitialAdLoadCallback(
                          onAdLoaded: (ad) {
                            controller.interstitialAd = ad;
                            controller.interstitialAd!.show();
                            controller
                                    .interstitialAd!.fullScreenContentCallback =
                                FullScreenContentCallback(
                              onAdFailedToShowFullScreenContent: (ad, error) {
                                //   ad.dispose();
                                controller.interstitialAd!.dispose();
                              },
                              onAdDismissedFullScreenContent: (ad) {
                                //         ad.dispose();
                                controller.interstitialAd!.dispose();
                                if (controller.isPlaying.value) {
                                  controller.pausePlayback();
                                  controller.run("Play");
                                } else {
                                  controller.playRecord(sound);
                                  controller.run("Stop");
                                }
                              },
                            );
                          },
                          onAdFailedToLoad: (error) {
                            // Ontab only one time
                            controller.buttontab.value = true;

                            if (controller.isPlaying.value) {
                              controller.pausePlayback();
                              controller.run("Play");
                            } else {
                              controller.playRecord(sound);
                              controller.run("Stop");
                            }
                          },
                        ));

                    debugPrint(err.message);
                  },
                ),
              );

              //  Add sow end
            } else if (check == "website") {
              // launchUrl(
              //   Uri.parse(link,forceWebView: false),
              //   mode: LaunchMode.externalApplication,
              // ).then((value) {
              //   controller.buttontab.value = true;
              //   if (controller.isPlaying.value) {
              //     controller.pausePlayback();
              //     controller.run("Play");
              // } else {
              //   controller.playRecord(sound);
              //   controller.run("Stop");
              // }
              //  });
              launchWebsiteAndPlaySound(link);
            } else {
              controller.buttontab.value = true;
              if (controller.isPlaying.value) {
                controller.pausePlayback();
                controller.run("Play");
              } else {
                controller.playRecord(sound);
                controller.run("Stop");
              }
            }
          }
        }
      },
      child: ColContainer(
        wigth: 340,
        hight: 55,
        Col: Orange,
        cir: 10,
        child: Center(
          child: Obx(
            () => Textcustom(
              text: controller.run.value == 'Stop'
                  ? 'Stop'
                  : '${controller.settingModel?.playButtonText}',

              //controller.run.value,
              weight: FontWeight.bold,
              col: white,
              size: 17,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> launchWebsiteAndPlaySound(String url) async {
    // Launch the website
    await launch(url, forceWebView: false);

    // This code will be executed when the website is dismissed.
    // You can resume or start playing the sound here.
    controller.buttontab.value = true;

    if (controller.isPlaying.value) {
      controller.pausePlayback();
      controller.run("Play");
    } else {
      controller.playRecord(sound);
      controller.run("Stop");
    }
  }
}

// ...


// ...

