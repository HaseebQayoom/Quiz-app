import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionIdentifer extends StatelessWidget {
  const QuestionIdentifer(
      {super.key, required this.isCorrectAnswer, required this.questionNumber});

  final bool isCorrectAnswer;
  final int questionNumber;

  @override
  Widget build(BuildContext context) {
   final questionNumberIndex = questionNumber + 1;

    return Container(
      height: 30,
      width: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(                                          //decoration yaha list of colours of excess krna ka lia istemal howa ha
        color: isCorrectAnswer
            ? const Color.fromARGB(255, 150, 198, 241)
            : const Color.fromARGB(255, 249, 133, 241),
        borderRadius: BorderRadius.circular(100),                         //border tadius 100 krna sa os widget ka irdgird daira ban jata hai
      ),
      child: Text(
        questionNumberIndex.toString(),                        //yaha text widget ko aik int value output ka lia de gaee ha jesa .toString() function ka zariya String mai tabdeel kia gaya hai
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 22, 2, 56),
        ),
      ),
    );
  }
}
