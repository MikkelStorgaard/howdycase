import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
import '../utils/extensions.dart';
import '../utils/typedefs.dart';

part 'evaluation.freezed.dart';

part 'evaluation.g.dart';

@freezed
class RawEvaluation with _$RawEvaluation {
  const RawEvaluation._();

  const factory RawEvaluation({
    required EmployeeId employeeId,
    required GroupId groupId,
    required DateTime answeredOn,
    required int answer1,
    required int answer2,
    required int answer3,
    required int answer4,
    required int answer5,
  }) = _RawEvaluation;

  factory RawEvaluation.fromJson(Map<String, Object?> json) =>
      _$RawEvaluationFromJson(json);

  Month get month => answeredOn.month;

  Day get day => answeredOn.day;
}

@freezed
class EmployeeEvaluations with _$EmployeeEvaluations {
  const EmployeeEvaluations._();

  const factory EmployeeEvaluations({
    required GroupId groupId,
    required MonthlyEmployeeEvaluations evaluations,
  }) = _EmployeeEvaluations;

  static EmployeeEvaluations fromRawEvaluation(RawEvaluation evaluation) =>
      EmployeeEvaluations(
          groupId: evaluation.groupId,
          evaluations: IMap.from(IntOrder, {
            evaluation.month: EmployeeAnswers.fromRawEvaluation(evaluation)
          }));

  EmployeeEvaluations maybePutEvaluation(RawEvaluation evaluation) {
    var updatedEvaluations = evaluations.get(evaluation.month).fold(
        () => evaluations.put(
            evaluation.month, EmployeeAnswers.fromRawEvaluation(evaluation)),
        (EmployeeAnswers existingEvaluation) =>
            // This implementation assumes that we can't answering the same questionnaire multiple times in one day
            existingEvaluation.day > evaluation.day
                ? evaluations
                : evaluations.put(evaluation.month,
                    EmployeeAnswers.fromRawEvaluation(evaluation)));
    return copyWith(evaluations: updatedEvaluations);
  }
}

@freezed
class GroupEvaluations with _$GroupEvaluations {
  const GroupEvaluations._();

  const factory GroupEvaluations({
    required MonthlyGroupEvaluations evaluations,
  }) = _GroupEvaluations;

  static GroupEvaluations fromEmployeeEvaluations(
          EmployeeEvaluations evaluations) =>
      GroupEvaluations(
          evaluations:
              evaluations.evaluations.map(GroupAnswers.fromEmployeeAnswers));

  GroupEvaluations appendEmployeeEvaluations(
      EmployeeEvaluations employeeEvaluations) {
    MonthlyGroupEvaluations accumulator(
        MonthlyGroupEvaluations acc, int month, EmployeeAnswers answers) {
      var key = month;
      var value = acc.get(key).fold(
          () => GroupAnswers.fromEmployeeAnswers(answers),
          (existingAnswers) => existingAnswers.appendEmployeeAnswers(answers));
      return acc.put(key, value);
    }

    var updatedEvaluations =
        employeeEvaluations.evaluations.foldLeftKV(evaluations, accumulator);
    return copyWith(evaluations: updatedEvaluations);
  }
}

@freezed
class EmployeeAnswers with _$EmployeeAnswers {
  const factory EmployeeAnswers({
    required int month,
    required int day,
    required int answer1,
    required int answer2,
    required int answer3,
    required int answer4,
    required int answer5,
  }) = _EmployeeAnswers;

  static fromRawEvaluation(RawEvaluation evaluation) => EmployeeAnswers(
      month: evaluation.month,
      day: evaluation.day,
      answer1: evaluation.answer1,
      answer2: evaluation.answer2,
      answer3: evaluation.answer3,
      answer4: evaluation.answer4,
      answer5: evaluation.answer5);
}

@freezed
class GroupAnswers with _$GroupAnswers {
  const GroupAnswers._();

  const factory GroupAnswers({
    required int month,
    required IList<int> answers1,
    required IList<int> answers2,
    required IList<int> answers3,
    required IList<int> answers4,
    required IList<int> answers5,
  }) = _GroupAnswers;

  static GroupAnswers fromEmployeeAnswers(EmployeeAnswers answers) =>
      GroupAnswers(
          month: answers.month,
          answers1: answers.answer1.wrapInIList(),
          answers2: answers.answer2.wrapInIList(),
          answers3: answers.answer3.wrapInIList(),
          answers4: answers.answer4.wrapInIList(),
          answers5: answers.answer5.wrapInIList());

  GroupAnswers appendEmployeeAnswers(EmployeeAnswers answers) => copyWith(
      answers1: answers1.appendElement(answers.answer1),
      answers2: answers2.appendElement(answers.answer2),
      answers3: answers3.appendElement(answers.answer3),
      answers4: answers4.appendElement(answers.answer4),
      answers5: answers5.appendElement(answers.answer5));

  Tuple5<double, double, double, double, double> get averages => Tuple5(
        answers1.average,
        answers2.average,
        answers3.average,
        answers4.average,
        answers5.average,
      );
}
