import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_api/data/question.dart';
import 'package:quiz_app_api/summary/question_summary.dart';
import 'package:http/http.dart' as http;

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.selectedAnswer,
    required this.restartQuiz,
  });

  final void Function() restartQuiz;
  final List<String> selectedAnswer;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Map<String, Object>> userSummary() {
    List<Map<String, Object>> summary = [];

    for (var i = 0; i < widget.selectedAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'user_answer': widget.selectedAnswer[i],
        'correct_answer': questions[i].answers[0],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final getUserSummary = userSummary();
    String? error;
    bool isLoading = false;

    final totalCorrectAnswer = getUserSummary.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    // void rSummary() {}

    savingResult() async {
      setState(() {
        isLoading = true;
      });
      try {
        final url = Uri.https(
          'quiz-results-7b912-default-rtdb.firebaseio.com',
          'quiz-result.json',
        );

        await http.post(
          url,
          headers: {'Content-type': 'application/json'},
          body: json.encode({'total_correct': totalCorrectAnswer}),
        );

        widget.restartQuiz;
      } catch (e) {
        error = 'Somthing went wrong in saving the data';
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Text(
          'You correctly answered $totalCorrectAnswer out of ${widget.selectedAnswer.length} questions',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 25),

        QuestionSummary(
          getuserSummary: getUserSummary,
        ), //user Summary jo ka list of maps ke shakal mai ha wo questionSummary ko pass ke ha

        const SizedBox(height: 20),

        //  Expanded(child: Row(
        //   children: [
        //     DropdownButton(items: , onChanged: onChanged)
        //   ],
        //  )),
        isLoading
            ? CircularProgressIndicator()
            : ElevatedButton.icon(
                onPressed: savingResult,
                style: ElevatedButton.styleFrom(
                  // foregroundColor: const Color.fromARGB(255, 123, 74, 207),
                  backgroundColor: const Color.fromARGB(255, 94, 30, 204),
                ),
                icon: const Icon(Icons.refresh_outlined, color: Colors.white),
                label: Text(
                  'Restart quiz!',
                  style: GoogleFonts.lato(
                    color: Colors.white,

                    // backgroundColor: const Color.fromARGB(255, 116, 70, 195),
                  ),
                ),
              ),
      ],
    );

    if (error != null) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(error!)],
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Container(margin: const EdgeInsets.all(40), child: content),
    );
  }
}
