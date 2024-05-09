import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sound/Controller/soundController/PlayControl.dart';
import 'package:sound/View/Sound/widget/backButton.dart';
import 'package:sound/View/Sound/widget/bannerAdsmall.dart';
import 'package:sound/View/Sound/widget/playbutton.dart';
import 'package:sound/utils/Appcustom.dart';
import 'package:sound/utils/custom/colContainer.dart';
import 'package:sound/utils/custom/textcustam.dart';
import 'package:audioplayers/audioplayers.dart';

class PlaySound extends StatefulWidget {
  String image;
  String name;
  String sound;
  String link;
  String check;
  Color col;
  String index;
  String modelText;
  PlaySound(
      {required this.image,
      required this.name,
      required this.sound,
      required this.link,
      required this.check,
      required this.col,
      required this.index,
      required this.modelText});

  @override
  State<PlaySound> createState() => _PlaySoundState();
}

class _PlaySoundState extends State<PlaySound> {
  final controller = Get.put(PlayController());
  @override
  void initState() {
    super.initState();

    controller.audioPlayer = AudioPlayer();
    controller.audioPlayer.onPlayerComplete.listen((event) {
      if (controller.value.value) {
        controller.playRecord(widget.sound);
      } else {
        controller.isPlaying(false);
        controller.run("Play");
      }
    });

    controller.setting();
  }

  @override
  void dispose() {
    controller.audioPlayer.dispose();
    controller.bannerAd!.dispose();
    controller.run.value = "Play";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backcol,
      body: SingleChildScrollView(
        child: Padding(
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
                  ///s
                  BackButtonCustam(),
                  Textcustom(
                    text: widget.name,
                    size: 20,
                    weight: FontWeight.w700,
                    col: white,
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ColContainer(
                wigth: 340,
                hight: 200,
                Col: Colors.blue,
                cir: 10,
                borderCol: black,
                boarder: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ImageContainer(wigth: 100, hight: 100, image: widget.image),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Textcustom(
                          text: widget.name,
                          size: 18,
                          weight: FontWeight.w700,
                          col: white,
                        ),
                        Textcustom(
                          text: widget.index,
                          size: 18,
                          weight: FontWeight.w700,
                          col: white,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Textcustom(
                    text: 'Loop',
                    col: white,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Textcustom(
                    text: 'Off',
                    weight: FontWeight.w600,
                    col: white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Obx(
                    () => Switch(
                      activeColor: Colors.transparent,
                      activeTrackColor: Orange,
                      // inactiveThumbColor: Colors.red,
                      inactiveTrackColor: Colors.transparent,
                      value: controller.value.value,
                      onChanged: (value) {
                        controller.value(value);
                        // if (controller.value.value) {
                        //   controller.check("on");
                        //   playRecord();
                        // } else {
                        //   controller.check("off");
                        //   pausePlayback();
                        // }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Textcustom(
                    text: 'On',
                    weight: FontWeight.w600,
                    col: white,
                  )
                ],
              ),

              SizedBox(
                height: 30,
              ),

              Center(
                child: Container(
                  width: 300,
                  //  color: Colors.amber,
                  child: Textcustom(
                      col: white,
                      align: TextAlign.center,
                      text: '${widget.modelText}'),
                ),
              ),
              SizedBox(
                height: 84,
              ),

//  Show Banner Or Button
              Obx(
                () => controller.adHaveError.value
                    ? PlayButton(
                        check: widget.check,
                        link: widget.link,
                        sound: widget.sound)
                    : BannerAdSmall(),
              ),

              //  SizedBox(
              //     //  color: Colors.amber,
              //     height: 50,
              //     child: AdWidget(ad: controller.bannerAd!)),

              SizedBox(
                height: 24,
              ),
              //
              //       Play Button
              //
              PlayButton(
                  check: widget.check, link: widget.link, sound: widget.sound)
            ],
          ),
        ),
      ),
    );
  }
}
