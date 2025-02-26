extension ConvertLowerCaseOneType on String {
  /// String? values if null or empty return true, not null or empty return false
  String get convertLowerCaseOneType => _convertLowerCaseOneType(this);
}

String _convertLowerCaseOneType(String text) {
  final List<List<String>> components = [
    ["ç", "c"],
    ["ğ", "g"],
    ["ı", "i"],
    ["ö", "o"],
    ["ş", "s"],
    ["ü", "u"]
  ];

  String myText = text.toLowerCase();

  for (var i = 0; i < components.length; i++) {
    myText = myText.replaceAll(components[i].first, components[i].last);
  }
  return myText;
}
