import 'package:flutter/material.dart';
import 'package:notesapp/screens/HomePage.dart';
import 'screens/Notes.dart';

void main() {
  runApp(MaterialApp(
    title: "Notes App",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Color(0xFF10316b), accentColor: Color(0xFFe25822)),
    home: HomePage(),
  ));
}
