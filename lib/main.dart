import 'package:flutter/material.dart';
import 'package:rto_apps/Screen/home_screen.dart';
import 'package:rto_apps/Screen/practice_question_section_page.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/Screen/spleshscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Spleshscreen(),
     // PracticeQuestions()
     //PracticeQuestionSectionPage()
     
    );
  }
}

class MyHomePage {
  const MyHomePage();
}