import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rto_apps/Screen/practice_question_section_page.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Map<String, dynamic>> get homeScreenList => [
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
      'cardColor': AppColors.yellowLightColoe,
      'icon': SvgPicture.asset(AppIcon.test),
    'title': 'Test', 
    'titleColor': AppColors.yellowDarkColors,
    'onTap': () {
     // Navigator.push(context, MaterialPageRoute(builder: (context) => PracticeQuestions()));
    },
    },
    {
      'cardColor': AppColors.greenColors,
      'icon': SvgPicture.asset(AppIcon.roadSign),
    'title': 'Road Signs', 
    'titleColor': AppColors.greenColors,
    'onTap': () {
    //  Navigator.push(context, MaterialPageRoute(builder: (context) => PracticeQuestions()));
    },
    },
    {
      'cardColor': AppColors.redColor,
      'icon': SvgPicture.asset(AppIcon.study),
    'title': 'Studt', 
    'titleColor': AppColors.redColor,
    'onTap': (){

    }
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
/////
  onTabClicked() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PracticeQuestions(setNumber: 10,)));
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(
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
              SizedBox(
                height: 900,
                child: ListView.separated(
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
}

class voidCallback {
}
