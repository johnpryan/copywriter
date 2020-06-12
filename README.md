Checks for copyright headers in each file.

## Usage
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
pub global activate --source path .
```