import 'dart:convert';
import 'dart:io';

Stream<File> filesWithoutCopyright(Stream<File> inputStream, String copyright) async* {
  await for (var file in inputStream) {
    var firstThreeLines = await _firstThreeLines(file);
    if (firstThreeLines != copyright) {
      yield file;
    }
  }
}

Future<String> _firstThreeLines(File file) {
  return file
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .take(3)
      .fold<String>('', (previous, element) {
    if (previous == '') return element;
    return previous + '\n' + element;
  });
}
