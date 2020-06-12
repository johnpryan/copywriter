// Copyright (c) 2020, John Ryan. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

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
