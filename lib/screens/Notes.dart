import 'package:flutter/material.dart';
import 'package:notesapp/screens/NotesEditor.dart';

class Notes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotesState();
  }
}

class NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Notes'))),
      body: Container(
        color: Color(0xFF000000),
        child: ListView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NotesEditor()));
        },
        tooltip: 'Add new Note',
      ),
    );
  }
}
