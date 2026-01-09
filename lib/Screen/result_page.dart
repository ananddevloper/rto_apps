import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rto_apps/Screen/home_screen.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/Screen/question_model.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.questions, required this.result, required this.title, });
  final List<QuestionModel> questions;
  final bool result;
  final String title;
  @override
  State<ResultPage> createState() => _ResultPageState();
}
class _ResultPageState extends State<ResultPage> {
int get score{
  return widget.questions.where((q)=>q.selectedAnswer == q.correctAnswer).length; //Add This Line
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
            child: Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(0),
              ),
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(
                  child: Column(
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
                      Text( textAlign: TextAlign.center,
                        'You\'ve just cleared driving licence test.\n Practice more to increses your success\n chances in actual test.',
                        style: TextStyle(
                          color: AppColors.whiteColors,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20,), //// Add this lie
                     getResultScore(title: 'Your Score is'),
                      
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          getBasicDesign(icon: Icons.home, title: 'Home     '),
                          getBasicDesign(
                            icon: Icons.refresh,
                            title: 'Try Again',
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
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Lottie.asset(AppAnimation.championAnimation),
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
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
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
                    getResultScore( title: 'Your Score is'),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:[
                        InkWell(
                          onTap: (){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => HomeScreen(),) , (route) => false);
                          },
                          child: Expanded(child: getBasicDesign(icon: Icons.home, title: 'Home       '))),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context, MaterialPageRoute(
                                  builder:(context) => PracticeQuestions( title: widget.title, examList: widget.questions,),));
                            },
                            child: getBasicDesign(
                              icon: Icons.refresh,
                              title: 'Try Again',
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
          child: Lottie.asset(AppAnimation.failAnimation),
        ),
      ],
    );
  }

  Card getBasicDesign({ IconData? icon, required String title}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColors,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Icon(
                icon,
                color: widget.result
                    ? AppColors.greenColors
                    : AppColors.redColor,
                size: 35,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: widget.result
                      ? AppColors.greenColors
                      : AppColors.redColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card getResultScore({required String title}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(30)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 15, 22, 15),
        child: Text(
              textAlign: TextAlign.center,
              '$title:-  $score/${widget.questions.length}',  //// Add this line
              style: TextStyle(
                color: widget.result
                    ? AppColors.greenColors
                    : AppColors.redColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
    );
  }
}
