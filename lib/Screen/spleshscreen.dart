import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:rto_apps/Screen/home_screen.dart';
import 'package:rto_apps/Screen/secon_splesh_screen.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Spleshscreen extends StatefulWidget {
  const Spleshscreen({super.key});
  @override
  State<Spleshscreen> createState() => _SpleshscreenState();
}

@override
class _SpleshscreenState extends State<Spleshscreen> {
  double opacity = 1.0;
  @override
  void initState() {
    super.initState();
    checkAgreement();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        opacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.welcomeBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                AppImage.logo,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(AppIcon.splashaCar),
          ),
          Positioned(
            bottom: 30,
            right: 10,
            left: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Lottie.asset(AppAnimation.carAnimation),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkAgreement() async {
    final prefs = await SharedPreferences.getInstance();
    bool isAgreed = prefs.getBool('isAgreed') ?? false;

    Future.delayed(Duration(seconds: 3), () {
      if (isAgreed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                SeconSpleshScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      }
    });
  }
}
