import 'dart:convert';
import 'dart:io';
import 'models/evaluation.dart';

List<RawEvaluation> parseEvaluationFile(String filepath) {
  var rawJson = File(filepath).readAsStringSync();
  var rawEvaluationList = jsonDecode(rawJson) as List;
  return rawEvaluationList.map((e) => RawEvaluation.fromJson(e)).toList();
}
