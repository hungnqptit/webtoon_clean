import 'dart:convert';
import 'dart:io';

void main() async {
  stdout.write("Options:\n");
  stdout.write("1: Generate filter 1 times\n");
  stdout.write("2: Generate filter many times\n");
  stdout.write("0: Exit\n");
  final option = stdin.readLineSync();
  switch (option) {
    case "1":
      _inputSingle();
      break;
    case "2":
      _inputList();
      break;
    case "0":
      exit(0);
  }
}

Stream<String> readLine() {
  stdout.write("Input path of file or folder:\n");
  stdout.write("Input 0 to Exit\n");

  return stdin.transform(utf8.decoder).transform(const LineSplitter());
}

void _inputSingle() async {
  stdout.write("Input path of file or folder:\n");
  final line = stdin.readLineSync() ?? "";
  final terminal =
      'flutter pub run build_runner build --delete-conflicting-outputs --build-filter "${line.contains(".dart") ? "${line.replaceAll(".dart", "").replaceAll("'", "")}.g.dart" : "${line.replaceAll("'", "")}/**"}"';
  stdout.write(
    terminal,
  );

  final result = await Process.start(
    "bash",
    ["-c", terminal],
  );
  result.stdout.transform(utf8.decoder).forEach((line) => stdout.write(line));
}

void processLine(String line) async {
  if (line == "0") {
    exit(0);
  }
  final terminal =
      'flutter pub run build_runner build --delete-conflicting-outputs --build-filter "${line.contains(".dart") ? "${line.replaceAll(".dart", "").replaceAll("'", "")}.g.dart" : "${line.replaceAll("'", "")}/**"}"';
  stdout.write(
    terminal,
  );

  final result = await Process.start(
    "bash",
    ["-c", terminal],
  );
  result.stdout
      .transform(utf8.decoder)
      .forEach((line) => stdout.write(line))
      .then(
    (value) {
      stdout.write("Input path of file or folder:\n");
      stdout.write("Input 0 to Exit\n");
    },
  );
}

void _inputList() {
  readLine().listen(processLine);
}
