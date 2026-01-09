import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rto_apps/Screen/practice_question_section_page.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/Screen/question_model.dart';
import 'package:rto_apps/Screen/question_bank.dart';
import 'package:rto_apps/Screen/road_sign.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> { 

List<QuestionModel> homeScreenLoadingList = [];

  List<Map<String, dynamic>> get homeScreenList => [
    {
      'cardColor': AppColors.redColor,
      'icon': SvgPicture.asset(AppIcon.study),
    'title': 'Question Bank', 
    'titleColor': AppColors.redColor,
    'onTap':() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionBank(questionList: homeScreenLoadingList.where((q)=> q.image == null || q.image!.isEmpty).toList())));
    }
    },
    {
      'cardColor': AppColors.appBarColors,
      'icon': SvgPicture.asset(AppIcon.aToZ),
    'title': 'Practical Questions', 
    'titleColor': AppColors.appBarColors,
    'onTap':  () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PracticeQuestionSectionPage()));
    },
    },
    {
      'cardColor': AppColors.greenColors,
      'icon': SvgPicture.asset(AppIcon.roadSign),
    'title': 'Road Signs', 
    'titleColor': AppColors.greenColors,
    'onTap': () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => RoadSignScreen(roadSign: homeScreenLoadingList.where((q)=> q.image !=null || (q.image?.isNotEmpty ?? false)).toList())));
    },
    },
    {
      'cardColor': AppColors.yellowLightColoe,
      'icon': SvgPicture.asset(AppIcon.test),
    'title': 'Test', 
    'titleColor': AppColors.yellowDarkColors,
    'onTap': () {
     // Navigator.push(context, MaterialPageRoute(builder: (context) => StudyScreen()));
    },
    },
    
    {
      'cardColor': AppColors.lightOrangeColor,
      'icon': SvgPicture.asset(AppIcon.test),
    'title': 'Test History', 
    'titleColor': AppColors.lightOrangeColor,
    'onTap': (){
    }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        backgroundColor: AppColors.appBarColors,

        leading: Icon(Icons.menu),
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColors,
          ),
        ),
        actions: [SvgPicture.asset(AppIcon.dots)],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              ListView.separated(
                shrinkWrap:  true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    color: AppColors.whiteColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 25, 10),
                      child: homeDesign(
                        cardColor: homeScreenList[index]['cardColor'],
                        icon: homeScreenList[index]['icon'],
                        title: homeScreenList[index]['title'], 
                        titleColor: homeScreenList[index]['titleColor'],
                       onTap: homeScreenList[index]['onTap'],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.transparent),
                itemCount: homeScreenList.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell homeDesign({
    required Color cardColor,
    required SvgPicture icon,
    required String title,
    required Color titleColor, 
   required Function()? onTap,
  }) {
    return InkWell(
     onTap: onTap, 
      child: Row(
        children: [
          Card(
            color: cardColor,
            child: SizedBox(height: 50, width: 50, child: Center(child: icon)),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,color: titleColor),
          ),
          Spacer(),
          SvgPicture.asset(AppIcon.arrow),
        ],
      ),
    );
  }

@override
  void initState() {
    super.initState();
    loadingHomeData();
  }
Future<void> loadingHomeData() async {
    final String response = await rootBundle.loadString(AppFile.dataJson);
    final List<dynamic> data = json.decode(response);
    final allQuestions = data.map((e) => QuestionModel.fromjson(e)).toList();
    homeScreenLoadingList = allQuestions;
    setState(() {
      
    });
  }

}


