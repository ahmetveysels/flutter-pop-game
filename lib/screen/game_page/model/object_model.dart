import 'package:flutter/material.dart';

class ObjectModel {
  final Key key;
  final String title;
  final int objectAlignIndex;
  final int objectIndex;
  ObjectModel({
    required this.key,
    required this.title,
    required this.objectAlignIndex,
    required this.objectIndex,
  });

  @override
  String toString() {
    return 'ObjectModel(key: $key, title: $title, objectAlignIndex: $objectAlignIndex, objectIndex: $objectIndex)';
  }
}

// burada da çoklıu dilde nasıl olur ona göre yama yapmak gerekiyor 
