import 'package:flutter/material.dart';
import 'package:quiz_app_api/quiz_sate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return QuizState();
  }
}
