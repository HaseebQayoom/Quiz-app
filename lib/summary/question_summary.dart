import 'package:flutter/material.dart';
import 'package:quiz_app_api/summary/summary_item.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary({super.key, required this.getuserSummary});

  final List<Map<String, Object>> getuserSummary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: getuserSummary.map(
            //.map Map sa alag ha ya original Map ko nhi cherti balka aik alag naksha(map) banati ha jes ka ander changes krna sa original Map ka andr koee tabdeeli nhi ayy ge
            (data) {
              return SummaryItem(
                userSummary: data,
              ); //QestionSummary class na list of maps mai sa maps aik aik kr ka Summary item ko pass kia ha jo ka 1question ke summary banti ha
            },
          ).toList(), //.map jo questions ke summary drhi ha osa list mai tabdeel krna ka lia
        ),
      ),
    );
  }
}
