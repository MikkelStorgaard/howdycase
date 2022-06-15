import 'package:howdycase/models/evaluation.dart';

import 'utils/typedefs.dart';

void _prettyPrintGroupEvaluations(
    GroupId groupId, GroupEvaluations evaluations) {
  print("Group $groupId");
  print("Month, Q1, Q2, Q3, Q4, Q5");
  evaluations.evaluations.forEachKV(_prettyPrintGroupAnswers);
  print("");
}

void _prettyPrintGroupAnswers(int month, GroupAnswers answers) {
  var averages = answers.averages;
  print(
      "$month, ${averages.value1.toStringAsFixed(1)} , ${averages.value2.toStringAsFixed(1)}, ${averages.value3.toStringAsFixed(1)}, ${averages.value4.toStringAsFixed(1)}, ${averages.value5.toStringAsFixed(1)}");
}

void prettyPrintGroupEvaluationsMap(GroupEvaluationsMap groupEvaluations) =>
    groupEvaluations.forEachKV(_prettyPrintGroupEvaluations);
