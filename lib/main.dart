import 'evaluator.dart';
import 'parser.dart';
import 'prettyprinter.dart';

void main(List<String> args) {
  if (args.length == 1) {
    var inputPath = args[0];
    var rawEvaluations = parseEvaluationFile(inputPath);
    var employeeEvaluations = fromRawEvaluations(rawEvaluations);
    var groupEvaluations = fromEmployeeEvaluationsMap(employeeEvaluations);

    prettyPrintGroupEvaluationsMap(groupEvaluations);
  } else {
    print(
        "This tool takes exactly one argument, namely the path to a json file containing a list of evaluation scores");
  }
}
