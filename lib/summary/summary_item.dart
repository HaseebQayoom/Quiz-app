import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_api/summary/question_identifer.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({super.key, required this.userSummary});

  final Map<String, Object> userSummary;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer =
        userSummary['user_answer'] == userSummary['correct_answer'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionIdentifer(
          isCorrectAnswer: isCorrectAnswer,
          questionNumber: userSummary['question_index'] as int,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, //ya question ko column ka shuru mai la ay ga or koee zadha gap nhi chora ga
            children: [
              Text(
                userSummary['question']
                    as String, //.map na jo questionsummary de the os ka question output kia jrha ha
                style: GoogleFonts.lato(
                  //or (as String) es lia ka es ke type cast batani hoti ha text widget ko jab bhi .map sa kuch output karwana ho
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                userSummary['user_answer'] as String,
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 249, 133, 241),
                ),
              ),
              Text(
                userSummary['correct_answer'] as String,
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 150, 198, 241),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
