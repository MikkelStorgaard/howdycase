import 'package:dartz/dartz.dart';
import 'models/evaluation.dart';
import 'utils/typedefs.dart';

EmployeeEvaluationsMap fromRawEvaluations(List<RawEvaluation> evaluations) {
  EmployeeEvaluationsMap accumulator(
      EmployeeEvaluationsMap acc, RawEvaluation evaluation) {
    var key = evaluation.employeeId;
    var value = acc.get(key).fold(
        () => EmployeeEvaluations.fromRawEvaluation(evaluation),
        (EmployeeEvaluations existingEvaluations) =>
            existingEvaluations.maybePutEvaluation(evaluation));
    return acc.put(key, value);
  }

  return evaluations.fold(IMap.empty(IntOrder), accumulator);
}

GroupEvaluationsMap fromEmployeeEvaluationsMap(
    EmployeeEvaluationsMap evaluations) {
  GroupEvaluationsMap accumulator(
      GroupEvaluationsMap acc, EmployeeEvaluations evaluations) {
    var key = evaluations.groupId;
    var value = acc.get(key).fold(
        () => GroupEvaluations.fromEmployeeEvaluations(evaluations),
        (GroupEvaluations existingEvaluations) =>
            existingEvaluations.appendEmployeeEvaluations(evaluations));
    return acc.put(key, value);
  }

  return evaluations.foldLeft(IMap.empty(IntOrder), accumulator);
}
