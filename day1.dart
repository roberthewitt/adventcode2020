import 'utils.dart';

void main() {
  List<int> numbers = [];

  readFileByLine("inputData_day1.txt", (element) {
    numbers.add(int.parse(element));
  }, onComplete: () {
    const input = 2020;
    List<int> foundMatch = findTriple(numbers, input);

    if (foundMatch.length > 0)
      multiply(foundMatch);
    else
      print('no matching numbers for query of $input');
  });
}

void multiply(List<int> v) =>
    print("multiplying: $v = ${v.reduce((a, b) => a * b)}");

List<int> findMatch(List<int> others, List<int> source, int sum) {
  List<int> result = [];
  var sourceVal = source.reduce((a, b) => a + b);
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
