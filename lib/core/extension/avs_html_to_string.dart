extension HtmltoString on String? {
  String get html2string => _htmlparser(this);
}

String _htmlparser(String? value) {
  RegExp exp = RegExp(r'<[^>]*>|&[^;]+;', multiLine: true, caseSensitive: true);
  String html = (value ?? "").replaceAll("<p>", " ").replaceAll("\n", " ");
  String parsedstring = html.replaceAll(exp, ' ').replaceAll("  ", " ");

  return parsedstring.trim();
}
