import 'package:dartz/dartz.dart';
import 'package:howdycase/models/evaluation.dart';

typedef Month = int;
typedef Day = int;
typedef EmployeeId = int;
typedef GroupId = int;
typedef EmployeeEvaluationsMap = IMap<EmployeeId, EmployeeEvaluations>;
typedef GroupEvaluationsMap = IMap<GroupId, GroupEvaluations>;
typedef MonthlyEmployeeEvaluations = IMap<Month, EmployeeAnswers>;
typedef MonthlyGroupEvaluations = IMap<Month, GroupAnswers>;
