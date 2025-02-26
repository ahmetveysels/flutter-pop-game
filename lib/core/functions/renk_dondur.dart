import 'package:flutter/material.dart';

Color renkDondur(int index) {
  switch (index % 5) {
    case 0:
      return const Color(0xFFE36159);
    case 1:
      return const Color(0xFF383f48);
    case 2:
      return const Color(0xFFeacb7e);
    case 3:
      return const Color(0xFF927167);
    case 4:
      return const Color(0xFFbe8cbf);
    default:
      return Colors.white;
  }
}
