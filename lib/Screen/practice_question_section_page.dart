import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rto_apps/Screen/introduction_page.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/Rto_Modals/question_model.dart';
import 'package:rto_apps/helper/add_helper.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/helper/asset_helper.dart';
import 'package:rto_apps/widget/intersetital_ad_helper.dart';
import 'package:rto_apps/widget/large_banner_widget.dart';
import 'package:rto_apps/widget/small_banner_widget.dart';

class PracticeQuestionSectionPage extends StatefulWidget {
  const PracticeQuestionSectionPage({
    super.key,
    required this.practiceQuestions,
  });
  final List<QuestionModel> practiceQuestions;
  @override
  State<PracticeQuestionSectionPage> createState() =>
      _PracticeQuestionSectionPageState();
}

class _PracticeQuestionSectionPageState
    extends State<PracticeQuestionSectionPage> {
  late BannerAd bannerAd;
  bool isAdLoaded = false;
  List<QuestionModel> allQuestions = [];

  @override
  void initState() {
    // TODO: implement initState
    getBannerAd();

    allQuestions = widget.practiceQuestions;
    super.initState();
  }

  final List<PracticeQuestionSectionModal> practiceQuestionSectionList =
      List.generate(27, (index) {
        return PracticeQuestionSectionModal(
          index: index + 1,
          title: 'Practice Questions Set ${index + 1}',
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteColors),
        title: Text(
          textAlign: TextAlign.center,
          'Practice Questions',
          style: TextStyle(
            color: AppColors.whiteColors,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.appBarColors,
      ),

      bottomNavigationBar: SmallBannerWidget(),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Scrollbar(
          // thumbVisibility: true,
          thickness: 10,
          radius: Radius.circular(30),
          child: ListView.separated(
            shrinkWrap: true,
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
                      int setIndex = practiceQuestionSectionList[index].index;
                      int startIndex = (setIndex - 1) * 31;
                      int endIndex = startIndex + 30;

                      print('start index $startIndex');
                      print('end index $endIndex');

                      List<QuestionModel> slectedQuestions = allQuestions
                          .sublist(
                            startIndex,
                            endIndex > allQuestions.length
                                ? allQuestions.length
                                : endIndex,
                          );
                      InterstitialAdManager.showAd(
                        onAdClosed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PracticeQuestions(
                                title: practiceQuestionSectionList[index].title,
                                examList: slectedQuestions,
                                showTimer: false,
                              ),
                            ),
                          );
                        },
                      );
                      
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Column(
                children: [
                  ((index + 1) % 4 == 0)
                      ? const LargeBannerAdWidget()
                      : SizedBox(height: 5),
                ],
              );
            },

            itemCount: practiceQuestionSectionList.length,
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
        children: [
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

  Future<void> getBannerAd() async {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AddHelper.bannerAdId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }
}
