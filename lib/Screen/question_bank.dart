import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rto_apps/Rto_Modals/question_model.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';

class QuestionBank extends StatefulWidget {
  const QuestionBank({super.key, required this.questionList});
  final List<QuestionModel> questionList; /////
  @override
  State<QuestionBank> createState() => _QuestionBankState();
}

class _QuestionBankState extends State<QuestionBank> {
  List<QuestionModel> questionBankList = [];
  //ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        backgroundColor: AppColors.appBarColors,
        title: Text(
          'Question Bank',
          style: TextStyle(
            color: AppColors.whiteColors,
            
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: questionBankList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Scrollbar(
         //   controller: scrollController,
            //  thumbVisibility: true,
              thickness: 10,
              radius: Radius.circular(30),
              child: ListView.separated(
              //  controller: scrollController,
                itemBuilder: (context, index) {
                  final questionSets = questionBankList[index]; ////
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: AppColors.whiteColors,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Q.${index + 1}.  ${questionSets.question}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            SizedBox(height: 10),
                            Text(
                              'Answer:- ${questionSets.correctAnswer}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greenColors,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: questionBankList.length,
              ),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    questionBankList = widget.questionList;
  }
}
