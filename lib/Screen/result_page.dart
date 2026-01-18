import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rto_apps/Screen/exam_history.dart';
import 'package:rto_apps/Screen/home_screen.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/Screen/Rto_Modals/question_model.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    super.key,
    required this.questions,
    required this.result,
    required this.title,
    required this.showTimer,
  });
  final List<QuestionModel> questions;
  final bool result;
  final String title;
  final bool showTimer;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int get score {
    return widget.questions
        .where((q) => q.selectedAnswer == q.correctAnswer)
        .length; //Add This Line
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.welcomeBackgroundColor,
      body: SafeArea(
        child: widget.result == true ? getPassView() : getFaildView(),
      ),
    );
  }

  Column getPassView() {
    return Column(
      children: [
        Expanded(
          child: Card(
            color: AppColors.greenColors,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
            margin: EdgeInsets.all(20),
            elevation: 10,
            shadowColor: AppColors.greenColors,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Congratulations',
                      style: TextStyle(
                        color: AppColors.whiteColors,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,
                      'You\'ve just cleared driving licence test exam.\n Practice more to increses your success\n chances in actual test.',
                      style: TextStyle(
                        color: AppColors.whiteColors,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20), //// Add this lie
                    getResultScore(title: 'Your Score is'),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: getBasicDesign(
                              icon: Icons.home,
                              title: 'Home',
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              for (var q in widget.questions) {
                                q.reset();
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExamHistory(),
                                ),
                              );
                            },
                            child: getBasicDesign(
                              icon: Icons.refresh,
                              title: 'Check History',
                            ),
                          ),
                        ),
                      ],
                    ),
                    //// Add this lie
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Lottie.asset(AppAnimation.championAnimation, height: 320),
        ),
      ],
    );
  }

  Column getFaildView() {
    return Column(
      children: [
        Expanded(
          child: Card(
            color: AppColors.redColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
            margin: EdgeInsets.all(20),
            elevation: 10,
            shadowColor: AppColors.redColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Failed!',
                      style: TextStyle(
                        color: AppColors.whiteColors,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,
                      'Sorry, you have failed in driving licence test We Would suggest you to refer question bank and try again.',
                      style: TextStyle(
                        color: AppColors.whiteColors,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    getResultScore(title: 'Your Score is'),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: getBasicDesign(
                              icon: Icons.home,
                              title: 'Home',
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              for (var q in widget.questions) {
                                q.reset();
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  // builder: (context) => PracticeQuestions(
                                  //   title: widget.title,
                                  //   examList: widget.questions,
                                  //   showTimer: widget.showTimer,
                                  // ),
                                  builder: (context) => ExamHistory(),
                                ),
                              );
                            },
                            child: getBasicDesign(
                              icon: Icons.refresh,
                              title: 'Check History',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Lottie.asset(AppAnimation.failAnimation, height: 320),
        ),
      ],
    );
  }

  Card getBasicDesign({IconData? icon, required String title}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Icon(
              icon,
              color: widget.result ? AppColors.greenColors : AppColors.redColor,
              size: 25,
            ),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                color: widget.result
                    ? AppColors.greenColors
                    : AppColors.redColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card getResultScore({required String title}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 15, 22, 15),
        child: Text(
          textAlign: TextAlign.center,
          '$title:-  $score/${widget.questions.length}', //// Add this line
          style: TextStyle(
            color: widget.result ? AppColors.greenColors : AppColors.redColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
