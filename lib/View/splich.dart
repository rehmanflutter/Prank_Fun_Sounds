// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:sound/utils/Appcustom.dart';
// import 'package:sound/utils/imagess.dart';

// class SplichScreen extends StatefulWidget {
//   @override
//   State<SplichScreen> createState() => _SplichScreenState();
// }

// class _SplichScreenState extends State<SplichScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Timer(Duration(seconds: 25), () {
//       Get.offAllNamed('/HomeScreen');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backcol,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 30),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//               height: 50,
//             ),
//             Column(
//               children: [
//                 Container(
//                   height: 150,
//                   width: 120,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage(Images.appimages),
//                           fit: BoxFit.cover)),
//                 ),
//               ],
//             ),
//             // SpinKitWave(
//             //   color: white,
//             //   size: 40.0,
//             // )
//             LinearProgressIndicator(
//                double =100.0,
//               color: Color(0xff41E8FF),
//               backgroundColor: Colors.transparent,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sound/Controller/soundController/PlayControl.dart';
import 'package:sound/utils/Appcustom.dart';
import 'package:sound/utils/imagess.dart';

class SplichScreen extends StatefulWidget {
  @override
  State<SplichScreen> createState() => _SplichScreenState();
}

class _SplichScreenState extends State<SplichScreen> {
  final ValueNotifier<double> progressValue = ValueNotifier<double>(0.0);
  final controller = Get.put(PlayController());
  @override
  void initState() {
    super.initState();
    controller..setting();
    Timer(Duration(seconds: 4), () {
      // Update the progress value to 100 after 5 seconds
      progressValue.value = 100.0;
      // Navigate to the home screen
      Get.offAllNamed('/HomeScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backcol,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Container(
                  height: 150,
                  width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.appimages),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            ValueListenableBuilder<double>(
              valueListenable: progressValue,
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: LinearProgressIndicator(
                    value: value / 100.0,
                    color: Color(0xff41E8FF),
                    backgroundColor: Colors.transparent,
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
