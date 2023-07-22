import 'dart:math' as math;

extension MapWithIndex<T> on Iterable<T> {
  List<U> mapWithIndex<U>(U Function(int, T) mapping) => toList()
      .asMap()
      .map((index, element) => MapEntry(index, mapping(index, element)))
      .values
      .toList();
}

extension MinMax on Iterable<double> {
  double min() => reduce(math.min);

  double max() => reduce(math.max);
}
