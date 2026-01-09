import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rto_apps/Screen/introduction_page.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/Screen/question_model.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';

class PracticeQuestionSectionPage extends StatefulWidget {
  const PracticeQuestionSectionPage({super.key, });
 
  @override
  State<PracticeQuestionSectionPage> createState() =>
      _PracticeQuestionSectionPageState();
}

class _PracticeQuestionSectionPageState
    extends State<PracticeQuestionSectionPage> {
  final List<PracticeQuestionSectionModal> practiceQuestionSectionList = List.generate(15, (index){
    return PracticeQuestionSectionModal(index: index + 1, title: 'Practice Questions Set');    
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        title: Text('Practice Questions',style: TextStyle(color: AppColors.whiteColors,fontSize: 20,fontWeight: FontWeight.bold),),
        backgroundColor: AppColors.appBarColors,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    color: AppColors.whiteColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
                      child: practiceQuestionSection(
                        index: practiceQuestionSectionList[index].index,
                        title: practiceQuestionSectionList[index].title,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute( 
                           builder: (context) => IntroductionPage(setNumber: index + 1, title: practiceQuestionSectionList[index].title,),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.transparent),
                itemCount: practiceQuestionSectionList.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell practiceQuestionSection({
    required int index,
    required String title,
    required Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children:[
          CircleAvatar(
            backgroundColor: AppColors.appBarColors,
            child: Text(
              index.toString(),
              style: TextStyle(
                color: AppColors.whiteColors,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          SvgPicture.asset(AppIcon.arrow),
        ],
      ),
    );
  }
}
