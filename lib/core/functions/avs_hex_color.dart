import 'package:flutter/material.dart';

Color avsHexColor(String hexColor, {double? opacity}) {
  String color = "";
  if (hexColor[0] == "#") {
    hexColor.substring(1);
  } else {
    color = hexColor;
  }

  String a = "0xFF$color";
  return Color(int.parse(a)).withOpacity(opacity ?? 1);
}
