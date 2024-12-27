extension StrExt on String {
  String get extractName {
    var splashIndex = lastIndexOf('/');
    var dotIndex = lastIndexOf('.');
    return substring(splashIndex + 1, dotIndex);
  }
}
