import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rto_apps/Rto_Modals/test_history_modal.dart';
import 'package:rto_apps/Screen/dialog_box.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/helper/add_helper.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/widget/intersetital_ad_helper.dart';
import 'package:rto_apps/widget/large_banner_widget.dart';
import 'package:rto_apps/widget/small_banner_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExamHistory extends StatefulWidget {
  const ExamHistory({super.key});
  @override
  State<ExamHistory> createState() => _ExamHistoryState();
}

class _ExamHistoryState extends State<ExamHistory> {
  late BannerAd bannerAd;
  bool isAdLoaded = false;
  //////////////////////////////////
  List<TestHistoryModal> historyList = [];
  bool isLoading = true;

  @override
  void initState() {
    getBannerAd();
    super.initState();
    getTestHistory();
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
          'Exam History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColors,
          ),
        ),
      ),
      bottomNavigationBar: SmallBannerWidget(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : historyList.isEmpty
          ? Center(
              child: Text(
                'No Exam History Found',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : Scrollbar(
              thickness: 10,
              radius: Radius.circular(30),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final history = historyList[index];
                    return InkWell(
                      onTap: () {
                        InterstitialAdManager.showAd(
                          onAdClosed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PracticeQuestions(
                                  examList: history.questionList ?? [],
                                  title: 'Exam History',
                                  showTimer: false,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Card(
                        color: AppColors.whiteColors,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  15,
                                  20,
                                  20,
                                  20,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: history.isPass
                                      ? AppColors.greenColors
                                      : AppColors.redColor,
                                  radius: 20,
                                  child: Icon(
                                    history.isPass ? Icons.check : Icons.close,
                                    color: AppColors.whiteColors,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  fromatDate(history.dateTime),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right),
                            ],
                          ),
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
                  itemCount: historyList.length,
                ),
              ),
            ),
    );
  }

  Future<void> getTestHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> savedList = pref.getStringList('test_history') ?? [];
    List<TestHistoryModal> tempList = savedList.map((e) {
      Map<String, dynamic> json = jsonDecode(e);
      return TestHistoryModal.fromJson(json);
    }).toList();
    setState(() {
      historyList = tempList.reversed.toList();
      isLoading = false;
    });
  }

  String fromatDate(DateTime? date) {
    if (date == null) return 'N/A';
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day}-${months[date.month - 1]}-${date.year}'
        '   '
        '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
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
