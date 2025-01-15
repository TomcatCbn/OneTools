import 'dart:io';

extension StrExt on String {
  String get extractName {
    var splashIndex = lastIndexOf('/');
    var dotIndex = lastIndexOf('.');
    return substring(splashIndex + 1, dotIndex);
  }

  String get toLocalBranch {
    if (isRemoteBranch) {
      var branchLocal = substring('remotes/origin/'.length);
      return branchLocal;
    }
    return this;
  }

  bool get isRemoteBranch {
    return startsWith('remotes/origin/');
  }

  String get adaptToMacFilePath {
    if (Platform.isMacOS) {
      return replaceFirst(RegExp(r'^/Volumes/Macintosh HD'), '');
    }
    return this;
  }
}
