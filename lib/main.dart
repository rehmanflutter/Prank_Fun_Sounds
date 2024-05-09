import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sound/Routes/routing.dart';
import 'package:sound/View/splich.dart';
import 'package:firebase_core/firebase_core.dart';

// real     version    3.19.3
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  await FacebookAudienceNetwork.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Air Horn Prank Fun Sounds',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplichScreen(),
      getPages: AppRouting.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
