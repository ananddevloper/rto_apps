import 'dart:isolate';

import 'package:rto_apps/Rto_Modals/question_model.dart';

class TestHistoryModal {
  List<QuestionModel>? questionList;
  DateTime? dateTime;
  final bool isPass;

  TestHistoryModal({
   required this.questionList,
    required this.dateTime,
    required this.isPass,
  });

  factory TestHistoryModal.fromJson(Map<String, dynamic> json) {
    return TestHistoryModal(
      questionList: (json['questionList'] as List)
          .map((e) => QuestionModel.fromHistoryjson(e))
          .toList(),
      dateTime: DateTime.parse(json['dateTime']),
      isPass: json['isPass'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionList': questionList?.map((e) => e.toJson()).toList(),
      'dateTime': dateTime.toString(),
      'isPass': isPass,
    };
  }

}
