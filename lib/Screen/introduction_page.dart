import 'package:flutter/material.dart';
import 'package:rto_apps/Screen/practice_question_section_page.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/helper/app_colors.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key, required this.setNumber, required this.title});
  final int setNumber;
  final String title;
  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        backgroundColor: AppColors.appBarColors,
        title: Text(
          'Exam',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteColors,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: AppColors.whiteColors,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '• Subject like Rules and Regulations of traffic, and traffic signage\'s are include in the test.\n\n • 15 question are asked in the test at rendom, out which 9 questions are required to be answered correctly to pass the test.\n\n • 30 seconds are allowed to answer each question. ',
                        style: TextStyle(
                          fontSize: 17,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => PracticeQuestions(
                                setNumber: widget.setNumber,
                                title: widget.title,
                              )));
                        },
                        child: Card(
                          elevation: 2,
                          child: Container(
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: AppColors.appBarColors,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'START EXAM',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whiteColors,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
