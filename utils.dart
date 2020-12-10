import 'dart:convert';
import 'dart:io';

readFileByLine(String filename, Function(String) line, {Function onComplete, Function solve}) {
  print("\n<<< using $filename");
  new File(filename).openRead().map(utf8.decode).transform(new LineSplitter()).forEach(line).whenComplete(() {
    if (solve != null) time(solve);
    if (onComplete != null) onComplete();
  });
}

void time(Function execution) {
  int start = DateTime.now().millisecondsSinceEpoch;
  execution();
  int end = DateTime.now().millisecondsSinceEpoch;
  print("execution time: ${end - start}(ms)");
}
