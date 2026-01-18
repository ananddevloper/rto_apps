import 'package:flutter/material.dart';
import 'package:rto_apps/Screen/home_screen.dart';
import 'package:rto_apps/Screen/practice_question_section_page.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/Screen/Rto_Modals/question_model.dart';
import 'package:rto_apps/helper/app_colors.dart';

class PracticeQuestionResultPage extends StatefulWidget {
  const PracticeQuestionResultPage({
    super.key,
    required this.questions,
    required this.result,
    required this.title,
  });
  final List<QuestionModel> questions;
  final bool result;
  final String title;
  @override
  State<PracticeQuestionResultPage> createState() =>
      _PracticeQuestionResultPageState();
}

class _PracticeQuestionResultPageState
    extends State<PracticeQuestionResultPage> {
  int get score =>
      widget.questions.where((q) => q.selectedAnswer == q.correctAnswer).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 80, 5, 5),
        child: Column(
          children: [
            SizedBox(height: 15),
            Card(
              color: AppColors.appBarColors,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Column(
                  children: [
                    Text(
                      'Thank You',
                      style: TextStyle(
                        color: AppColors.whiteColors,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'You\'ve just cleared driving licence test exam Practice more to increses your success chances in actual test.',
                      style: TextStyle(
                        color: AppColors.whiteColors,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            // Divider(color: AppColors.appBarColors, thickness: 5),
            SizedBox(height: 20),
            Text(
              'Check your correct Answers',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.appBarColors,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _getAnswerInfo(AppColors.redColor, 'Wrong'),
                  _getAnswerInfo(AppColors.greenColors, 'Right'),
                  _getAnswerInfo(AppColors.yellowDarkColors, 'Not Attempted'),
                ],
              ),
            ),

            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),

                itemCount: widget.questions.length,
                itemBuilder: (context, index) {
                  final question = widget.questions[index];
                  Color cardColor;

                  // bool isCorrect =
                  //     question.selectedAnswer == question.correctAnswer;
                  // Not attempted

                  if (!question.isAnswered) {
                    cardColor = AppColors.yellowDarkColors;

                    // Correct answer
                  } else if (question.selectedAnswer ==
                      question.correctAnswer) {
                    cardColor = AppColors.greenColors;
                  } else {
                    cardColor = AppColors.redColor;
                  }
                  return Card(
                    color: cardColor,
                    elevation: 2,
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColors,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false,
                    );
                  },
                  child: Card(
                    color: AppColors.whiteColors,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Icon(
                              Icons.home,
                              size: 35,
                              color: AppColors.appBarColors,
                            ),
                          ),

                          Text(
                            'Home    ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appBarColors,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    for (var q in widget.questions) {
                      q.reset();
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PracticeQuestions(
                          examList: widget.questions,
                          title: widget.title,
                          showTimer: widget.result,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    // yeha se project panding hai
                    color: AppColors.appBarColors,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 35,
                            color: AppColors.whiteColors,
                          ),
                          Text(
                            'Try Again',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColors,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Row _getAnswerInfo(Color color, String text) {
    return Row(
      children: [
        CircleAvatar(radius: 8, backgroundColor: color),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: AppColors.appBarColors,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
