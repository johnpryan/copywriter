// Copyright (c) 2020, John Ryan. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:copywriter/copywriter.dart';
import 'package:path/path.dart' as path;

const _red = '\u001b[31m';
const _green = '\u001b[32m';
const _noColor = '\u001b[0m';

Future main(List<String> args) async {
  var parser = ArgParser();
  parser.addOption('file',
      abbr: 'f',
      help: 'Path to file containing the copyright header',
      defaultsTo: '.copyright');
  parser.addFlag('help',
      abbr: 'h', help: 'Displays this information.', negatable: false);
  parser.addFlag('dry-run',
      abbr: 'd',
      help: 'Prints files without a copyright header and exits.',
      negatable: false);
  parser.addOption('extension',
      abbr: 'e',
      defaultsTo: '.dart',
      help: 'The file extension to recursively search for in the current \n'
          'directory. All files with this extension will be checked for a\n'
          'copyright header and written unless --dry-run is set.');

  var argResults = parser.parse(args);
  if (argResults['help']) {
    print(parser.usage);
    exit(0);
  }

  var copyrightFilePath = argResults['file'];

  var copyrightFile = File(copyrightFilePath);
  if (!await copyrightFile.exists()) {
    print('File not found. $copyrightFilePath');
  }
  var copyright = copyrightFile.readAsStringSync().trim();

  var currentDirectory = Directory.current;

  var files = currentDirectory
      .list(recursive: true)
      .where((entity) => entity is File)
      .where((file) => path.extension(file.path) == argResults['extension'])
      .cast<File>();

  var filesToEdit = await filesWithoutCopyright(files, copyright).toList();

  if (argResults['dry-run'] == true) {
    if (filesToEdit.isEmpty) {
      print('All files have a copyright header!');
      exit(0);
    }

    print('$_red${filesToEdit.length}$_noColor files have a missing or '
        'incorrect copyright header.\n');
    for (var file in filesToEdit) {
      print(path.relative(file.path, from: currentDirectory.path));
    }

    exit(1);
  }

  for (var file in filesToEdit) {
    await _writeCopyright(file, copyright);
  }

  print('$_green${filesToEdit.length}$_noColor files updated.');
}

Future _writeCopyright(File file, String copyright) async {
  var header = renderCopyrightTemplate(copyright);
  var contents = await file.readAsString();
  await file.writeAsString(header + '\n\n' + contents);
}
