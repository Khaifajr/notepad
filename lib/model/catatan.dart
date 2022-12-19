import 'package:flutter/material.dart';

class Catatan {
  int? id;
  String title;
  String konten;

  static var notesColor;

  Catatan({
    required this.id,
    required this.title,
    required this.konten,
  });

  factory Catatan.fromJson(Map<String, dynamic> obj) {
    return Catatan(
        id: int.tryParse('${obj['id']}'),
        title: obj['title'],
        konten: obj['konten']);
  }
}
