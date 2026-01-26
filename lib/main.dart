import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rto_apps/Screen/home_screen.dart';
import 'package:rto_apps/Screen/introduction_page.dart';
import 'package:rto_apps/Screen/practice_question_result_page.dart';
import 'package:rto_apps/Screen/practice_question_section_page.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/Screen/secon_splesh_screen.dart';
import 'package:rto_apps/Screen/spleshscreen.dart';
import 'package:rto_apps/Screen/result_page.dart';
import 'package:rto_apps/firebase_options.dart';
import 'package:rto_apps/widget/intersetital_ad_helper.dart';
import 'package:rto_apps/widget/reward_ad_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MobileAds.instance.initialize();
  InterstitialAdManager.loadAd();
  RewardAdHelper.loadAd(); // 👈 preload
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RTO EXAM',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Spleshscreen(),

      // PracticeQuestionResultPage(questions: [],)
      // SecondSpleshScreen(),
    );
  }
}

class MyHomePage {
  const MyHomePage();
}
