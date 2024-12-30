extension StrExt on String {
  String get extractName {
    var splashIndex = lastIndexOf('/');
    var dotIndex = lastIndexOf('.');
    return substring(splashIndex + 1, dotIndex);
  }

  String get toLocalBranch {
    if (startsWith('remotes/origin/')) {
      var branchLocal = substring('remotes/origin/'.length);
      return branchLocal;
    }
    return this;
  }
}
