import 'package:flutter/material.dart';

class NotesEditor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotesEditorState();
  }
}

class NotesEditorState extends State<NotesEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Create new Note')),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              cursorColor: Color(0xFFe25822),
              cursorWidth: 2.0,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2),
              decoration: InputDecoration(
                  hintText: 'Title ...',
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),01
          ),
          Divider(
            endIndent: 100.0,
            indent: 100.0,
            color: Color(0xFFe25822),
            height: 0,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              cursorColor: Color(0xFFe25822),
              cursorWidth: 2.0,
              maxLines: null,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 1.2),
              decoration: InputDecoration(
                  hintText: 'Note',
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 1.2),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
        ],
      ),
    );
  }
}
