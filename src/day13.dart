import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

Processor day13() {
  var output = Processor();

  Iterable<int> busIds = [];
  int departureTimestamp = 0;

  output.callback = (line) {
    if (departureTimestamp == 0) {
      departureTimestamp = int.parse(line);
    } else {
      busIds = line.split(",").where((e) => e != "x").map(int.parse);
    }
  };

  output.pt1 = () {
    var quickestTime = busIds
        .fold<Map<int, int>>({}, (acc, busId) {
          acc[busId] = busTimeAfter(busId: busId, target: departureTimestamp, current: 0);
          return acc;
        })
        .entries
        .fold<List<int>>([], (acc, entry) {
          if (acc.isEmpty) acc = [entry.key, entry.value];
          if (entry.value < acc[1]) acc = [entry.key, entry.value];
          return acc;
        });

    print(quickestTime);

    return (quickestTime[1] - departureTimestamp) * quickestTime[0];
  };

  output.pt2 = () => 0;

  return output;
}

main() {
  var day = 13;
  var testData = "data/day${day}_testData.txt";
  var realData = "data/day${day}.txt";

  var processor_testData = day13();
  readFileByLine(testData, processor_testData.callback, solve: () {
    print('<< day $day pt 1 >> ${processor_testData.pt1()}');
  }, onComplete: () {
    var processor_pt1 = day13();
    readFileByLine(realData, processor_pt1.callback, solve: () {
      print('<< day $day pt 1 >> ${processor_pt1.pt1()}');
    }, onComplete: () {
      var processor_pt2 = day13();
      readFileByLine(realData, processor_pt2.callback, solve: () {
        print('<< day $day pt 2 >> ${processor_pt2.pt2()}');
      });
    });
  });
}

int busTimeAfter({
  int busId,
  int target,
  int current,
}) {
  while (current < target) current += busId;
  return current;
}
