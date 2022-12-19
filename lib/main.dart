// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:notepad/ui/page_catatan.dart';
import 'package:notepad/ui/registrasi_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'note pad',
      debugShowCheckedModeBanner: false,
      home: PageCatatan(),
    );
  }
}
