Checks for copyright headers in each Dart file.

[![CI](https://github.com/johnpryan/copywriter/workflows/Dart%20CI/badge.svg)](https://github.com/johnpryan/copywriter/actions?query=branch%3Amaster)

## Usage

Activate this package:

```
dart pub global activate copywriter
```

Create a `.copyright` file in the root of your project, containing a template:

```
// Copyright {{ year }} John Doe. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
```

Then run the `copywriter` commmand. 
A copyright header is added to any `.dart` files missing the header.
The `{{ year }}` tag is ignored. When the tool writes new copyright headers,
the current year is used.


```
copywriter --help
-f, --file         Path to file containing the copyright header
                   (defaults to ".copyright")
-h, --help         Displays this information.
-d, --dry-run      Prints files without a copyright header and exits.
-e, --extension    The file extension to recursively search for in the current 
                   directory. All files with this extension will be checked for a
                   copyright header and written unless --dry-run is set.
                   (defaults to ".dart")
```

## Developing

clone and activate this package:

```
dart pub global activate --source path .
```
