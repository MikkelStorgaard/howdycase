// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RawEvaluation _$$_RawEvaluationFromJson(Map<String, dynamic> json) =>
    _$_RawEvaluation(
      employeeId: json['employeeId'] as int,
      groupId: json['groupId'] as int,
      answeredOn: DateTime.parse(json['answeredOn'] as String),
      answer1: json['answer1'] as int,
      answer2: json['answer2'] as int,
      answer3: json['answer3'] as int,
      answer4: json['answer4'] as int,
      answer5: json['answer5'] as int,
    );

Map<String, dynamic> _$$_RawEvaluationToJson(_$_RawEvaluation instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'groupId': instance.groupId,
      'answeredOn': instance.answeredOn.toIso8601String(),
      'answer1': instance.answer1,
      'answer2': instance.answer2,
      'answer3': instance.answer3,
      'answer4': instance.answer4,
      'answer5': instance.answer5,
    };
