import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function(String bagType) pt1;
  int Function(String bagType) pt2;
}

class BagContains {
  int quantity;
  String bagName;

  BagContains(this.quantity, this.bagName);
}

Processor newProcessor() {
  var output = Processor();

  List<String> lines = [];
  output.callback = lines.add;

  bool bagContainsBag(Map<String, Iterable<BagContains>> bag, String search, Iterable<BagContains> contents) =>
      contents.any((content) => content.bagName == search) ||
      contents.any((element) => bagContainsBag(bag, search, bag[element.bagName]));

  int bagSize(Iterable<BagContains> contents, Map<String, Iterable<BagContains>> data) =>
      contents.fold<int>(1, (old, bagContain) => old + bagContain.quantity * bagSize(data[bagContain.bagName], data));

  Map<String, Iterable<BagContains>> Function() bags =
      () => lines.fold<Map<String, Iterable<BagContains>>>({}, (acc, line) {
            var splits = line.split(" bags contain ");
            var sourceBag = splits[0].trim();
            var contains = splits[1].split(",");
            var bagTypeRegEx = RegExp("([0-9]{1,2}) ([a-z]* [a-z]*) bags?");
            var contents = contains
                .map((e) => e.trim())
                .where((e) => e != "no other bags.")
                .map((e) => bagTypeRegEx.firstMatch(e))
                .map((e) => BagContains(int.parse(e.group(1)), e.group(2)));

            return {...acc, sourceBag: contents};
          });

  output.pt1 = (rule) {
    var data = bags();
    return data.entries.where((entry) => bagContainsBag(data, rule, entry.value)).length;
  };

  output.pt2 = (search) {
    var data = bags();
    return bagSize(data[search], data) - 1;
  };

  return output;
}

main() {
  var processor_testData = newProcessor();
  readFileByLine("data/day7_testData.txt", processor_testData.callback, onComplete: () {
    print('<< test data result: ${processor_testData.pt1("shiny gold")}');
  });

  var processor_pt1 = newProcessor();
  readFileByLine("data/day7.txt", processor_pt1.callback, onComplete: () {
    print('<< part 1 >> result: ${processor_pt1.pt1("shiny gold")}');
  });

  var processor_testData2 = newProcessor();
  readFileByLine("data/day7_testData2.txt", processor_testData2.callback, onComplete: () {
    print('<< test data PART 2 result: ${processor_testData2.pt2("shiny gold")}');
  });

  var processor_pt2 = newProcessor();
  readFileByLine("data/day7.txt", processor_pt2.callback, onComplete: () {
    print('<< part 2 >> result: ${processor_pt2.pt2("shiny gold")}');
  });
}
