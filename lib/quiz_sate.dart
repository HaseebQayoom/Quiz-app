import 'package:flutter/material.dart';
import 'package:quiz_app_api/data/question.dart';
import 'package:quiz_app_api/question_screen.dart';
import 'package:quiz_app_api/result_screen.dart';
import 'package:quiz_app_api/start_screen.dart';

class QuizState extends StatefulWidget {
  const QuizState({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<QuizState> {
  List<String> selectedAnswer = [];
  var activeScreen = 'start_screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'question_screen';
    });
  }

  void afterchoosingAnswer(String answer) {
    selectedAnswer.add(answer);

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = 'result_screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswer = [];
      activeScreen = 'question_screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetScreen = StartScreen(switchScreen);

    if (activeScreen == 'question_screen') {
      widgetScreen = QuestionScreen(onSelectAnswer: afterchoosingAnswer);
    }

    if (activeScreen == 'result_screen') {
      widgetScreen = ResultScreen(
        restartQuiz: restartQuiz,
        selectedAnswer: selectedAnswer,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(116, 71, 194, 1),
                Color.fromARGB(255, 47, 13, 143),
              ],
            ),
          ),
          child: Center(child: widgetScreen),
        ),
      ),
    );
  }
}
