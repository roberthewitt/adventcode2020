import 'dart:convert';
import 'dart:io';

readFileByLine(String filename, Function(String) line, {Function onComplete}) =>
    new File(filename)
        .openRead()
        .map(utf8.decode)
        .transform(new LineSplitter())
        .forEach(line)
        .whenComplete(onComplete);
