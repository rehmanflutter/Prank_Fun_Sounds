import 'package:get/get_navigation/get_navigation.dart';
import 'package:sound/View/Sound/playsound.dart';
import 'package:sound/View/Sound/soundchose.dart';
import 'package:sound/View/home/home.dart';
import 'package:sound/View/splich.dart';

class AppRouting {
  static final routes = [
    GetPage(
        name: '/SplichScreen',
        page: () => SplichScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/HomeScreen',
        page: () => HomeScreen(),
        transition: Transition.downToUp),

    GetPage(
        name: '/SoundChose',
        page: () => SoundChose(
              index: '',
              soundName: '',
            ),
        transition: Transition.circularReveal),
    // GetPage(
    //     name: '/PlaySound',
    //     page: () => PlaySound(),
    //     transition: Transition.circularReveal),

    //    GetPage(
    // name: '/SiginScreen',
    // page: () => SiginScreen(),),
  ];
}
