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
  int Function() pt1;
  int Function() pt2;
}

class Person {
  List<String> votes = [];

  Person({this.votes = const []});
}

class Group {
  List<Person> people = [];

  int pt1() => people
      .map((e) => e.votes)
      .fold([], (a, b) => Set.from([...a, ...b])).length;

  int pt2() => people
      .map((e) => e.votes)
      .fold<Iterable<String>>(
          people[0].votes, (a, b) => a.where((v) => b.contains(v)))
      .length;
}

List<Group> getGroups(List<String> lines) {
  List<Group> groups = [Group()];

  lines.forEach((line) {
    if (line.isEmpty) {
      groups.add(Group());
    } else {
      groups.last.people.add(Person(votes: removeDuplicates(line.split(""))));
    }
  });

  return groups;
}

Processor newProcessor() {
  var output = Processor();

  List<String> lines = [];
  output.processLine = lines.add;

  output.pt1 =
      () => getGroups(lines).map((e) => e.pt1()).fold(0, (a, b) => a + b);

  output.pt2 =
      () => getGroups(lines).map((e) => e.pt2()).fold(0, (a, b) => a + b);

  return output;
}

main() {
  var processor_testData = newProcessor();
  readFileByLine("data/day6_testData.txt", processor_testData.processLine,
      onComplete: () {
    print('<< test data result: ${processor_testData.pt1()}');
  });

  var processor_pt1 = newProcessor();
  readFileByLine("data/day6.txt", processor_pt1.processLine, onComplete: () {
    print('<< part 1 >> result: ${processor_pt1.pt1()}');
  });

  var processor_pt2 = newProcessor();
  readFileByLine("data/day6.txt", processor_pt2.processLine, onComplete: () {
    print('<< part 2 >> result: ${processor_pt2.pt2()}');
  });
}
