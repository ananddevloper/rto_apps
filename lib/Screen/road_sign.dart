import 'package:flutter/material.dart';
import 'package:rto_apps/Screen/question_model.dart';
import 'package:rto_apps/helper/app_colors.dart';

class RoadSignScreen extends StatefulWidget {
  const RoadSignScreen({super.key, required this.roadSign});
  final List<QuestionModel> roadSign;

  @override
  State<RoadSignScreen> createState() => _RoadSignScreenState();
}

class _RoadSignScreenState extends State<RoadSignScreen> {
  List<QuestionModel> roadSignList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColors,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Road Signs',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColors,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final roadSigns = roadSignList[index];
            return Card(
              elevation: 2,
              color: AppColors.whiteColors,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Text('${index+1}.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    SizedBox(width: 2,),
                    Image.network(roadSigns.image ?? '', height: 150, width: 150 ,), 
                    Expanded(child: Text('${roadSigns.correctAnswer}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.blackColor,),))
                  ],
                ),
                
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemCount: roadSignList.length,
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
