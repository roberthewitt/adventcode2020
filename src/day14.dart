import '../utils.dart';

class Processor {
  Function(String) callback;
  int Function() pt1;
  int Function() pt2;
}

Processor day14() {
  var output = Processor();


  output.callback = (line) {

  };

  output.pt1 = () {
   return 0;
  };

  output.pt2 = () {
    return 0;
  };

  return output;
}

main() {
  var day = 14;
  var testData = "data/day${day}_testData.txt";
  var realData = "data/day${day}.txt";

  var processor_testData = day14();
  readFileByLine(testData, processor_testData.callback, solve: () {
    print('<< day $day pt 1 >> ${processor_testData.pt1()}');
  }, onComplete: () {
    var processor_pt1 = day14();
    readFileByLine(realData, processor_pt1.callback, solve: () {
      print('<< day $day pt 1 >> ${processor_pt1.pt1()}');
    }, onComplete: () {
      var processor_pt2 = day14();
      readFileByLine(realData, processor_pt2.callback, solve: () {
        print('<< day $day pt 2 >> ${processor_pt2.pt2()}');
      });
    });
  });
}
