import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  final image1 = 'assets/fontpage.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(image1,
        height: 80,),
        const SizedBox(height: 20),
        Text(
          'Learn flutter the fun way!',
          style: GoogleFonts.lato(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
            onPressed: () {
              startQuiz();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 195, 75, 255),
              backgroundColor: const Color.fromARGB(255, 93, 0, 255)
            ),
            icon: const Icon(Icons.arrow_right_alt_rounded,color: Colors.white),
            label: const Text(
              'Start quiz!',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
