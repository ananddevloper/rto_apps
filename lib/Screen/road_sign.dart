import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rto_apps/Rto_Modals/question_model.dart';
import 'package:rto_apps/Screen/question_bank.dart';
import 'package:rto_apps/helper/add_helper.dart';
import 'package:rto_apps/helper/app_colors.dart';
import 'package:rto_apps/widget/large_banner_widget.dart';
import 'package:rto_apps/widget/small_banner_widget.dart';

class RoadSignScreen extends StatefulWidget {
  const RoadSignScreen({super.key, required this.roadSign});
  final List<QuestionModel> roadSign;
  @override
  State<RoadSignScreen> createState() => _RoadSignScreenState();
}

class _RoadSignScreenState extends State<RoadSignScreen> {
  List<QuestionModel> roadSignList = []; ////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBarColors,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Road Signs',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColors,
          ),
        ),
      ),
      bottomNavigationBar: SmallBannerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Scrollbar(
          thickness: 10,
          radius: Radius.circular(30),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final roadSigns = roadSignList[index]; ////
              return Card(
                elevation: 2,
                color: AppColors.whiteColors,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 0, 0),
                  child: Stack(
                    children: [
                      Text(
                        '${index + 1}.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Image.network(
                            roadSigns.image ?? '',
                            height: 140,
                            width: 100,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${roadSigns.correctAnswer}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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

            itemCount: roadSignList.length,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    roadSignList = widget.roadSign;
    super.initState();
  }
}
