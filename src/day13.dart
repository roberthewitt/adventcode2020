import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

Processor day13() {
  var output = Processor();

  List<int> busIds = [];
  int departureTimestamp = 0;

  output.callback = (line) {
    if (departureTimestamp == 0) {
      departureTimestamp = int.parse(line);
    } else {
      busIds = line.split(",").map((e) => e == "x" ? "-1" : e).map(int.parse).toList();
    }
  };

  output.pt1 = () {
    var quickestTime = busIds
        .where((e) => e != -1)
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

  output.pt2 = () {
    var maxIndex = 0;
    var maxValue = 0;
    for (var i = 0; i < busIds.length; i++) {
      if (busIds[0] > maxValue) {
        maxValue = busIds[i];
        maxIndex = i;
      }
    }

    var currentTimestamp = maxValue - maxIndex;
    while (!worksFor(timestamp: currentTimestamp, busList: busIds)) currentTimestamp += maxValue;

    return currentTimestamp;
  };

  return output;
}

bool worksFor({int timestamp, List<int> busList}) {
  // print("checking timestamp: $timestamp");
  for (var i = 1; i < busList.length; i++) {
    if (busList[i] == -1) continue;
    if (((timestamp + i) % busList[i]) != 0) return false;
  }
  return true;
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
