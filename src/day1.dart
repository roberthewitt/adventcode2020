import '../utils.dart';

void main() {
  var processor = newProcessor();
  readFileByLine("data/day1.txt", processor.callback, onComplete: () {
    for(int i = 2; i < 6; i++) {
      var startTime = DateTime.now();
      var result = processor.findMatch(sum: 2020, size: i);
      var endTime = DateTime.now();
      print("$result :: duration(${endTime.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch}ms)");
    }
  });
}

class Output {
  Function(String line) callback;
  String Function({int sum, int size}) findMatch;
}

Output newProcessor() {
  List<int> data = [];
  var output = new Output();
  output.callback = (line) {
    data.add((int.parse(line)));
  };
  output.findMatch = ({sum, size}) {
    var result = find(data, size, sum, []);
    if (result.isEmpty) {
      return 'sum: $sum with size: $size: No Match';
    } else {
      return 'sum: $sum with size: $size: $result = ${result.reduce((a, b) => a * b)}';
    }
  };
  return output;
}

List<int> find(List<int> source, int setSize, int sum, List<int> lockedIn) {
  if (setSize == 1) {
    var lockedInSum = lockedIn.reduce((a, b) => a + b);
    var match = source.where((v) => v + lockedInSum == sum);
    return match.isEmpty ? [] : [...lockedIn, match.first];
  } else {
    for (int i = 0; i < source.length; i++) {
      int first = source[i];
      var newLockedIn = [...lockedIn, first];
      // give up this loop if we're already higher than sum
      if (newLockedIn.fold(0, (a, b) => a + b) >= sum) continue;
      List<int> others = source.sublist(i + 1);
      var match = find(others, setSize - 1, sum, newLockedIn);
      if (match.isNotEmpty) return match;
    }
  }
  return [];
}