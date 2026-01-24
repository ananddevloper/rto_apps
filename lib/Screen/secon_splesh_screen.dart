import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rto_apps/Screen/home_screen.dart';
import 'package:rto_apps/Settings/privacy_policy.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeconSpleshScreen extends StatefulWidget {
  const SeconSpleshScreen({super.key});

  @override
  State<SeconSpleshScreen> createState() => _SeconSpleshScreenState();
}

class _SeconSpleshScreenState extends State<SeconSpleshScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Image.asset(AppImage.logo, height: 200),
                      ),
                      Container(
                        padding: EdgeInsets.all(18),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.appBarColors,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Disclaimer',
                              style: TextStyle(
                                color: AppColors.whiteColors,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'This test is only for public awareness. Though all efforts have been made to ensure the accuracy of the content, the same should not be construed as a statement of law or used for any legal purposes. This application accepts no responsibility in relation to the accuracy, completeness, usefulness or otherwise, of the contents. Users are advised to verify/check any information with the Transport Department.',
                              style: TextStyle(
                                color: AppColors.whiteColors,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 25),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.whiteColors,
                    fontSize: 14,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(
                      text: "By tapping 'I Agree', you are agreeing to our\n",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 16,
                      ),
                    ),

                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommonWebView(
                                title: 'Privacy Policy',
                                url:
                                    'https://rto-exam-9134e.web.app/privacy_policy.html',
                              ),
                            ),
                          );
                        },
                    ),
                    TextSpan(
                      text: ' & ',
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    TextSpan(
                      text: 'Terms & Conditions',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommonWebView(
                                title: 'Terms & Conditions',
                                url:
                                    'https://rto-exam-9134e.web.app/terms_conditions.html',
                              ),
                            ),
                          );
                        },
                    ),
                    TextSpan(
                      text: '.',
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isAgreed', true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Card(
                  elevation: 2,
                  color: AppColors.appBarColors,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'I AGREE',
                              style: TextStyle(
                                color: AppColors.whiteColors,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  exit(0);
                },
                child: Text(
                  'I DISAGREE',
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
