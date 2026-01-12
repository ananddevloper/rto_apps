import 'package:flutter/material.dart';
import 'package:rto_apps/Screen/home_screen.dart';
import 'package:rto_apps/Screen/introduction_page.dart';
import 'package:rto_apps/Screen/practice_question_result_page.dart';
import 'package:rto_apps/Screen/practice_question_section_page.dart';
import 'package:rto_apps/Screen/practice_questions.dart';
import 'package:rto_apps/Screen/spleshscreen.dart';
import 'package:rto_apps/Screen/result_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RTO EXAM',
      theme: ThemeData(        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Spleshscreen(),
      // PracticeQuestionResultPage(questions: [],)
      
     
    );
  }
}
class MyHomePage {
  const MyHomePage();
}