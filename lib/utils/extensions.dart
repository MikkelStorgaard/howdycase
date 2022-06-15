import 'package:dartz/dartz.dart';
import 'package:collection/collection.dart';

extension ObjectExtensions<T> on T {
  IList<T> wrapInIList() => IList.from([this]);
}

extension IntIListExtensions on IList<int> {
  double get average => toIterable().average;
}
