import 'package:flutter/material.dart';

class Catatan {
  String title;
  String konten;

  static var notesColor;

  Catatan({
    required this.title,
    required this.konten,
  });

  factory Catatan.fromJson(Map<String, dynamic> obj) {
    return Catatan(
      title: obj['title'],
      konten: obj['konten'],
    );
  }
}
