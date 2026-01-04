import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rto_apps/Screen/question_model.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';

class PracticeQuestions extends StatefulWidget {
  const PracticeQuestions({super.key, required this.setNumber});
  final int setNumber;
  @override
  State<PracticeQuestions> createState() => _PracticeQuestionsState();
}

class _PracticeQuestionsState extends State<PracticeQuestions> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  Timer? _timer;
  int secondsLeft = 1000;
  Future<List<QuestionModel>>? futureQuestions;

  @override
  void initState() {
    startTestTimer();
    super.initState();
    futureQuestions = loadQuestionsFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.welcomeBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColors,
        title: Text(
          'Practice Questions',
          style: TextStyle(
            color: AppColors.whiteColors,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: FutureBuilder<List<QuestionModel>>(
        future: futureQuestions,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }
          final questions = asyncSnapshot.data!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.appBarColors,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Question:- ${currentIndex + 1}/${questions.length}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColors,
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: AppColors.whiteColors,
                            size: 16,
                          ),
                          SizedBox(width: 10),
                          Text(
                            formatTime(secondsLeft),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColors,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: PageView.builder(
                    itemCount: questions.length,
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final questionModel = questions[index];
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            Card(
                              elevation: 2,
                              color: AppColors.whiteColors,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Q.${currentIndex + 1}.',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            "${questionModel.question}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      questionModel.selectAnswer(
                                        questionModel.options[index],
                                      );
                                    });
                                  },
                                  child: Card(
                                    elevation: 2,
                                    color: questionModel.getOptionColor(
                                      questionModel.options[index],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 15,
                                      ),
                                      child: Row(
                                        children: [
                                          Text('${optionLabel(index)}.'),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              // textAlign: TextAlign.start,
                                              // questionModel.options[index],
                                              '${questionModel.options[index]}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                              itemCount: questionModel.options.length,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      elevation: 3,
                      color: AppColors.whiteColors,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (currentIndex > 0) {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Text(
                            'Previous',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.appBarColors,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (currentIndex < questions.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Card(
                        elevation: 3,
                        color: AppColors.appBarColors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.whiteColors,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void startTestTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        timer.cancel();
        _showTimeUpDialog();
      }
    });
  }

  String formatTime(int seconds) {
    final min = seconds ~/ 60;
    final sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Time Up"),
        content: const Text("Your test time is over"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  String optionLabel(int index) {
    return String.fromCharCode(65 + index);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<List<QuestionModel>> loadQuestionsFromJson() async {
    final String jsonString = await rootBundle.loadString(AppFile.dataJson);
    final List<dynamic> jsonList = jsonDecode(jsonString);
    List<QuestionModel> questions = jsonList
        .map((json) => QuestionModel.fromjson(json))
        .toList();

    var data = questions.sublist(
      (widget.setNumber - 1) * 10,
      (widget.setNumber * 10) - 1,
    );
    return data;
  }
}
