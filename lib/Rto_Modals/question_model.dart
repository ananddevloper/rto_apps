import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rto_apps/helper/app_colors.dart';
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
  final String correctAnswer;
  bool isAnswered = false; //false
  void reset() {
    selectedAnswer = null;
    isAnswered = false;
  }

  QuestionModel({
    required this.question,
    required this.heading,
    required this.explanation,
    required this.options,
    required this.id,
    required this.image,
    required this.selectedAnswer,
    required this.correctAnswer,
  });

  factory QuestionModel.fromjson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      heading: json['heading'],
      explanation: json['explanation'],
      options: json['questions'].cast<String>(),
      id: json['id'],
      image: json['image'],
      // selectedAnswer: json['selectedAnswer'],
      selectedAnswer: null,
      correctAnswer: json['answer'],
    );
  }
  factory QuestionModel.fromHistoryjson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      heading: json['heading'],
      explanation: json['explanation'],
      options: json['questions'].cast<String>(),
      id: json['id'],
      image: json['image'],
      selectedAnswer: json['selectedAnswer'],
      correctAnswer: json['answer'],
    )..isAnswered = true;
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'heading': heading,
      'explanation': explanation,
      'questions': options,
      'id': id,
      'image': image,
      'selectedAnswer': selectedAnswer,
      'answer': correctAnswer,
    };
  }

  /// check if option is selected
  bool isSelected(String option) {
    return selectedAnswer == option;
  }

  /// check if option is correct
  bool isCorrect(String option) {
    return option == correctAnswer;
  }

  bool isWrong(String? option) {
    if (option == null) return false;
    return option != correctAnswer;
  }

  /// return color for option
  Color getOptionColor(String option, bool isExam) {
    // Abhi kuch select nahi hua
    if (isExam) {
      if (option == selectedAnswer) {
        return Colors.blue.shade200;
      }
    } else {
      if (selectedAnswer == null) {
        return Colors.white;
      }

      // ✅ Sahi answer hamesha GREEN
      if (option == correctAnswer) {
        return Colors.green.shade200;
      }

      // ❌ User ne jo galat select kiya → RED
      if (option == selectedAnswer && option != correctAnswer) {
        return Colors.red.shade200;
      }
    }
    // Baaki options
    return Colors.white;
  }

  /// select answer only once
  void selectAnswer(String answer) {
    selectedAnswer = answer;
    isAnswered = true;
    print('selectedAnswer = $selectedAnswer');
  }
}

class PracticeQuestionSectionModal {
  late final int index;
  late final String title;
  PracticeQuestionSectionModal({required this.index, required this.title});
}
