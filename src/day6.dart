import '../utils.dart';

List<String> removeDuplicates(List<String> values) {
  List<String> result = [];

  values.forEach((element) {
    if (!result.contains(element)) result.add(element);
  });

  return result;
}

class Processor {
  Function(String) processLine;
  int Function() yes;
}

class Person {
  List<String> votes = [];

  Person({this.votes = const []});
}

class Group {
  List<Person> people = [];

  int uniqueVotes() => people
      .map((e) => e.votes)
      .fold([], (a, b) => Set.from([...a, ...b])).length;
}

Processor newProcessor() {
  var output = Processor();

  List<String> lines = [];
  output.processLine = lines.add;

  output.yes = () {
    List<Group> groups = [Group()];

    lines.forEach((line) {
      if (line.isEmpty) {
        groups.add(Group());
      } else {
        groups.last.people.add(Person(votes: removeDuplicates(line.split(""))));
      }
    });

    return groups.map((e) => e.uniqueVotes()).fold(0, (a, b) => a + b);
  };

  return output;
}

main() {
  var processor_testData = newProcessor();
  readFileByLine("data/day6_testData.txt", processor_testData.processLine,
      onComplete: () {
    print('<< test data result: ${processor_testData.yes()}');
  });

  var processor_pt1 = newProcessor();
  readFileByLine("data/day6.txt", processor_pt1.processLine, onComplete: () {
    print('<< part 1 >> result: ${processor_pt1.yes()}');
    // 1601 is too low and wrong
    // 1263 and too low
    // 1504 too low
  });

  // var processor_pt2 = newProcessor();
  // readFileByLine("data/day6.txt", processor_pt2.processLine, onComplete: () {
  //   print('<< part 2 >> my seat: ${processor_pt2.mySeat()}');
  // });
}
