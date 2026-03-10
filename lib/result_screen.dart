import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_api/data/question.dart';
import 'package:quiz_app_api/summary/question_summary.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  final url = Uri.https(dotenv.env['API_KEY']!, 'quiz-result.json');
  List<int> prevResult = [];

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

  late final getUserSummary = userSummary();
  String? error;
  bool isLoading = false;

  late final totalCorrectAnswer = getUserSummary.where((data) {
    return data['user_answer'] == data['correct_answer'];
  }).length;

  Future<void> previousResult() async {
    List<int> preVResult = [];

    try {
      // final url = Uri.https(dotenv.env['API_KEY']!, 'quiz_result.json');
      // final url = Uri.https(dotenv.env["API_KEY"]!, 'quiz_result.json');

      final respone = await http.get(url);
      // print(respone.body);

      if (respone.statusCode >= 400) {
        print('Status code is ${respone.statusCode}');
      }
      final results = await jsonDecode(
        respone.body,
      ); //yaha await lagana bhol gaya tha jes ke waja sa initState function he nhi arha tha

      // print('3$results');

      for (var res in results.entries) {
        preVResult.add(res.value['total_correct_answer']);
      }

      //  for(var ans in preVResult){
      //   dropDown.add(DropdownMenuItem(child: Text('You have correctly answered $ans from 5 quesions')));
      //  }
    } catch (e) {
      error = 'error while fetching data';
    }

    // setState(() {
    //   prevResult = preVResult;
    // });
    // print('4$prevResult');

    showModalBottomSheet(
      context: context,
      builder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var ans in preVResult)
              Text(
                'You have correctly answered $ans from 5 questions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> savingResult() async {
    setState(() {
      isLoading = true;
    });

    try {
      // final url = Uri.https(dotenv.env['API_KEY']!, 'quiz-result.json');

      // final response = await http.get(url);
      // print('2');
      // print(response.body);

      await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode({'total_correct_answer': totalCorrectAnswer}),
      );
      // previousResult();
      widget.restartQuiz();
    } catch (e) {
      error = 'Somthing went wrong in saving the data';
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (error != null) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(error!)],
      );
    }
    content = Column(
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

        // DropdownButton(
        //   value: Text('Previous results'),
        //   items: prevResult
        //       .map(
        //         (ans) => DropdownMenuItem(
        //           value: Text('prev result'),
        //           child: Text(
        //             'You have correctly answered $ans out of 5 questions',
        //           ),
        //         ),
        //       )
        //       .toList(),
        //   onChanged: (value) => value,
        // ),
        TextButton(onPressed: previousResult, child: Text('Previous answer')),

        const SizedBox(height: 20),
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

    return SizedBox(
      width: double.infinity,
      child: Container(margin: const EdgeInsets.all(40), child: content),
    );
  }
}
