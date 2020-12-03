import 'dart:convert';
import 'dart:io';

void main() {
  List<int> numbers = [];

  new File("puzzleInput.txt")
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((element) {
    numbers.add(int.parse(element));
  }).whenComplete(() {
    List<int> foundMatch = findTriple(numbers, 2020);

    multiply(foundMatch);
  });
}

void multiply(List<int> values) {
  var result = values.reduce((previousValue, element) => previousValue * element);
  print("multiplying: $values = $result");
}

List<int> findMatch(List<int> others, List<int> source, int sum) {
  List<int> result  = [];
  var sourceVal = source.reduce((a,b) => a+b);
  var matching = others.where((e) => (e + sourceVal) == sum);
  if (matching.isNotEmpty) {
    result = [...source, matching.first];
  }
  return result;
}

List<int> findTriple(List<int> numbers, int sum) {
  for (var i = 0; i < numbers.length; i++) {
    var primary = numbers[i];
    var innerNumbers = numbers.where((element) => element != primary).toList();
    for (var j = 0; j < innerNumbers.length; j++) {
      var secondary = numbers[j];
      var finalNumbers = innerNumbers.where((e) => e != secondary).toList();
      var match = findMatch(finalNumbers, [primary, secondary], sum);
      if (match.length > 0) {
        return match;
      }
    }
  }
  return [];
}
