import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:rto_apps/Settings/settin_page.dart';
import 'package:rto_apps/Screen/exam_history.dart';
import 'package:rto_apps/Screen/introduction_page.dart';
import 'package:rto_apps/Screen/practice_question_section_page.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/Rto_Modals/question_model.dart';
import 'package:rto_apps/Screen/question_bank.dart';
import 'package:rto_apps/Screen/road_sign.dart';
import 'package:rto_apps/helper/add_helper.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';
import 'package:rto_apps/widget/intersetital_ad_helper.dart';
import 'package:rto_apps/widget/large_banner_widget.dart';
import 'package:rto_apps/widget/small_banner_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //////////

  bool isLoading = true;
  String? selectedState;
  List<QuestionModel> homeScreenLoadingList = [];

  List<Map<String, dynamic>> get homeScreenList => [
    {
      'cardColor': AppColors.redColor,
      'icon': SvgPicture.asset(AppIcon.study),
      'title': 'Question Bank',
      'titleColor': AppColors.redColor,
      'arrowIcon': SvgPicture.asset(AppIcon.arrow, color: AppColors.redColor),
      'onTap': () {
        InterstitialAdManager.showAd(
          onAdClosed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuestionBank(questionList: homeScreenLoadingList),
              ),
            );
          },
        );
      },
    },
    {
      'cardColor': AppColors.greenColors,
      'icon': SvgPicture.asset(AppIcon.roadSign),
      'title': 'Road Signs',
      'titleColor': AppColors.greenColors,
      'arrowIcon': SvgPicture.asset(
        AppIcon.arrow,
        color: AppColors.greenColors,
      ),
      'onTap': () {
        InterstitialAdManager.showAd(
          onAdClosed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RoadSignScreen(roadSign: homeScreenLoadingList),
              ),
            );
          },
        );
      },
    },

    {
      'cardColor': AppColors.appBarColors,
      'icon': SvgPicture.asset(AppIcon.practiceQuestion),
      'title': 'Practice Questions',
      'titleColor': AppColors.appBarColors,
      'arrowIcon': SvgPicture.asset(
        AppIcon.arrow,
        color: AppColors.appBarColors,
      ),
      'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PracticeQuestionSectionPage(
              practiceQuestions: homeScreenLoadingList,
            ),
          ),
        );
      },
    },
    
    {
      'cardColor': AppColors.orange,
      'icon': SvgPicture.asset(AppIcon.exam),
      'title': 'Exam',
      'titleColor': AppColors.orange,
      'arrowIcon': SvgPicture.asset(AppIcon.arrow, color: AppColors.orange),
      'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IntroductionPage(
              title: 'Exam',
              examList: homeScreenLoadingList,
            ),
          ),
        );
      },
    },
    {
      'cardColor': AppColors.lightOrangeColor,
      'icon': SvgPicture.asset(AppIcon.study),
      'title': 'Exam History',
      'titleColor': AppColors.lightOrangeColor,
      'arrowIcon': SvgPicture.asset(
        AppIcon.arrow,
        color: AppColors.lightOrangeColor,
      ),
      'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExamHistory()),
        );
      },
    },
  ];

  @override
  void initState() {
    loadingHomeData();
    checkForUpdate();
    // loadInterstitialAd();
    // loadingRtoOffices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        backgroundColor: AppColors.appBarColors,
        title: Text(
          'RTO EXAM',
          style: TextStyle(
            color: AppColors.whiteColors,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),

     bottomNavigationBar: SmallBannerWidget(),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
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
                        arrowIcon: homeScreenList[index]['arrowIcon'],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.transparent),
                itemCount: homeScreenList.length,
              ),
              SizedBox(height: 10),
             LargeBannerAdWidget(),
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
    required SvgPicture arrowIcon,
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
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
          Spacer(),
          arrowIcon,
        ],
      ),
    );
  }

  Future<void> loadingHomeData() async {
    final String response = await rootBundle.loadString(AppFile.dataJson);
    final List<dynamic> data = json.decode(response);
    final allQuestions = data.map((e) => QuestionModel.fromjson(e)).toList();
    homeScreenLoadingList = allQuestions;
    setState(() {});
  }

  Future<String?> getSavedState() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('selected_state');
  }

  Future<void> loadSelectedState() async {
    selectedState = await getSavedState();
    setState(() {});
  }

void checkForUpdate() async {
  AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

  if (updateInfo.updateAvailability ==
          UpdateAvailability.updateAvailable &&
      updateInfo.flexibleUpdateAllowed) {

    await InAppUpdate.startFlexibleUpdate();
    await InAppUpdate.completeFlexibleUpdate();
  }
}

}