import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rto_apps/helper/asset_helper.dart';

class QuestionModel {
  final String question;
  final String heading;
  final String explanation;
  String? image;
  final List<String> options;
  String? answer;
  final int id;
  String? selectedAnswer;

  QuestionModel({
    required this.question,
    required this.heading,
    required this.explanation,
    required this.options,
    required this.id,
    required this.image,
    required this.selectedAnswer,
  });

  factory QuestionModel.fromjson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      heading: json['heading'],
      explanation: json['explanation'],
      options: json['questions'].cast<String>(),
      id: json['id'],
      image: json['image'],
      selectedAnswer: json['selectedAnswer'],
    );
  }



  /// check if option is selected
  bool isSelected(String answer) {
    return selectedAnswer == answer;
  }

  /// check if option is correct
  bool isCorrect(String answer) {
    return answer == selectedAnswer;
  }

  /// return color for option
  Color getOptionColor(String answer) {
    if (selectedAnswer == null) {
      return Colors.white;
    }

    if (isCorrect(answer)) {
      return Colors.green.shade200;
    }

    if (isSelected(answer) && !isCorrect(answer)) {
      return Colors.red.shade200;
    }

    return Colors.white;
  }

  /// select answer only once
  void selectAnswer(String answer) {
    selectedAnswer ??= answer;
  }
}

class PracticeQuestionSectionModal {
  late final int index;
  late final String title;

  PracticeQuestionSectionModal({required this.index, required this.title});
}
