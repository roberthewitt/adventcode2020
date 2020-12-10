import '../utils.dart';

class Processor {
  Function(String) processLine;
  int Function() pt1;
  int Function() pt2;
}

class Person {
  Iterable<String> votes = [];

  Person({this.votes = const []});
}

class Group {
  List<Person> people = [];

  int pt1() => people.map((e) => e.votes).fold([], (a, b) => Set.from([...a, ...b])).length;

  int pt2() => people
      .map((e) => e.votes)
      .fold((people.isEmpty ? [] : people[0].votes), (a, b) => a.where((v) => b.contains(v)))
      .length;
}

List<Group> getGroups(List<String> lines) {
  List<Group> groups = [Group()];

  lines.forEach((line) {
    if (line.isEmpty) {
      groups.add(Group());
    } else {
      groups.last.people.add(Person(votes: Set.from(line.split(""))));
    }
  });

  return groups;
}

Processor newProcessor() {
  var output = Processor();

  List<String> lines = [];
  output.processLine = lines.add;

  output.pt1 = () => getGroups(lines).map((e) => e.pt1()).fold(0, (a, b) => a + b);

  output.pt2 = () => getGroups(lines).map((e) => e.pt2()).fold(0, (a, b) => a + b);

  return output;
}

main() {
  var processor_testData = newProcessor();
  readFileByLine("data/day6_testData.txt", processor_testData.processLine, solve: () {
    print('<< test data result: ${processor_testData.pt1()}');
  }, onComplete: () {
    var processor_pt1 = newProcessor();
    readFileByLine("data/day6.txt", processor_pt1.processLine, solve: () {
      print('<< part 1 >> result: ${processor_pt1.pt1()}');
    }, onComplete: () {
      var processor_pt2 = newProcessor();
      readFileByLine("data/day6.txt", processor_pt2.processLine, solve: () {
        print('<< part 2 >> result: ${processor_pt2.pt2()}');
      });
    });
  });
}
