import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rto_apps/Screen/question_model.dart';
import 'package:rto_apps/Screen/result_page.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';

class PracticeQuestions extends StatefulWidget {
  const PracticeQuestions({
    super.key,
    required this.setNumber,
    required this.title,
  });
  final int setNumber;
  final String title;
  @override
  State<PracticeQuestions> createState() => _PracticeQuestionsState();
}

class _PracticeQuestionsState extends State<PracticeQuestions> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  int rightCount = 0;
  int wrongCount = 0;
  Timer? _timer;
  int secondsLeft = 10 * 1;

  List<QuestionModel> questionList = [];

  @override
  void initState() {
    startTestTimer();
    super.initState();
    loadQuestionsFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.welcomeBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        backgroundColor: AppColors.appBarColors,
        title: Text(
          '${widget.title}',
          style: TextStyle(
            color: AppColors.whiteColors,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [getTimerView()],
      ),

      body: questionList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
                        child: Row(
                          children: [
                            Text(
                              'Questions:- ${currentIndex + 1}/${questionList.length}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColors,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.greenColors,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                // topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),

                                // bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: AppColors.whiteColors,
                                  size: 20,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  rightCount.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whiteColors,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.redColor,
                              borderRadius: BorderRadius.only(
                                // topLeft: Radius.circular(0),
                                topRight: Radius.circular(25),
                                // bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.close,
                                  color: AppColors.whiteColors,
                                  size: 20,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  wrongCount.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whiteColors,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // getTimerView(),
                    ],
                  ),

                  Expanded(
                    child: PageView.builder(
                      itemCount: questionList.length,
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final questionModel = questionList[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      if (questionModel.image != null &&
                                          questionModel.image!.isNotEmpty)
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              questionModel.image ?? '',
                                              height: 150,
                                              width: 150,
                                            ),
                                          ),
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
                                        if (questionModel.isAnswered) return;
                                        // Answer select karo
                                        questionModel.selectAnswer(
                                          questionModel.options[index],
                                        );
                                        //Count logic
                                        if (questionModel.isCorrect(
                                          questionModel.options[index],
                                        )) {
                                          rightCount++;
                                        } else {
                                          wrongCount++;
                                        }
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
                                            Text(
                                              '${optionLabel(index)}.',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.blackColor,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                questionModel.options[index],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
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
                          if (currentIndex < questionList.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            bool isPass = rightCount >= 12;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                  questions: questionList,
                                  result: isPass,
                                  title: widget.title,
                                  setNumber: widget.setNumber,
                                ),
                              ),
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
                              currentIndex == questionList.length - 1
                                  ? 'Submit'
                                  : 'Next',
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
            ),
    );
  }

  Container getTimerView() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.redColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Icon(Icons.timer, color: AppColors.whiteColors, size: 16),
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
        showTimeUpDialog();
      }
    });
  }

  String formatTime(int seconds) {
    final min = seconds ~/ 60;
    final sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  void showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.homePageBackground,
        title:  Text("Time Over",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: AppColors.appBarColors),),
        content:  Text(textAlign: TextAlign.center,
          "Better luck for next time",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              bool isPass = rightCount >= 12;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    questions: questionList,
                    result: isPass,
                    title: widget.title,
                    setNumber: widget.setNumber,
                  ),
                ),
              );
            },
            child:  Text("OK",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.appBarColors),),
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
      (widget.setNumber - 1) * 16,
      (widget.setNumber * 16) - 1,
    );
    questionList = data;
    setState(() {});
    return data;
  }
  
}
