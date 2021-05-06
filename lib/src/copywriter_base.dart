// Copyright (c) 2020, John Ryan. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'package:mustache/mustache.dart' as mustache;

Stream<File> filesWithoutCopyright(
    Stream<File> inputStream, String copyright) async* {
  await for (var file in inputStream) {
    var firstThreeLines = await _firstThreeLines(file);
    if (!isValidCopyright(copyright, firstThreeLines)) {
      yield file;
    }
  }
}

bool isValidCopyright(String expected, String test) {
  var rendered = mustache.Template(expected).renderString({'year': '[0-9]*'});
  var regex = RegExp(rendered);
  return regex.hasMatch(test);
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

/// Takes a .copyright file and produces the copyright string to
/// append to each file. Replaces the first regex group with the
/// current year.
String renderCopyrightTemplate(String copyrightFileString) {
  return mustache.Template(copyrightFileString)
      .renderString({'year': DateTime.now().year});
}
