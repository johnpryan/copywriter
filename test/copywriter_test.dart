import 'package:copywriter/copywriter.dart';
import 'package:test/test.dart';

void main() {
  group('copywriter', () {
    test('checks copyright', () {
      var expected = '''// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.''';
      var testCopyright =
          '''// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.''';
      expect(isValidCopyright(expected, testCopyright), true);
    });

    test('checks copyright against a mustache template', () {
      var expected =
          '''// Copyright {{ year }} The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.''';
      for (var year in [1999, 2019, 2020]) {
        var testCopyright =
        '''// Copyright $year The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.''';
        expect(isValidCopyright(expected, testCopyright), true);
      }
    });

    test('Writes copyright', () {
      var copyrightFileString =
          '''// Copyright {{ year }} The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.''';
      var expected =
          '''// Copyright ${DateTime.now().year} The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.''';
      expect(renderCopyrightTemplate(copyrightFileString), expected);
    });
  });
}
