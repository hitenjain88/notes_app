import 'package:flutter/material.dart';

class NotesEditor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotesEditorState();
  }
}

class NotesEditorState extends State<NotesEditor> {
  Color backColor = Color(0xFF000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: backColor,
        elevation: 0.0,
        child: Container(
          color: backColor,
          height: 40.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                color: Colors.white,
                onPressed: () {
                  showBottomPopup();
                },
                alignment: Alignment.centerRight,
                iconSize: 20.0,
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: backColor,
        elevation: 0.0,
        titleSpacing: 1.2,
        centerTitle: true,
        title: Text('Create new Note'),
      ),
      backgroundColor: backColor,
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
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: backColor)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: backColor))),
            ),
          ),
//          Divider(
//            endIndent: 100.0,
//            indent: 100.0,
//            color: Color(0xFFe25822),
//            height: 0,
//          ),
          Expanded(
            child: Container(
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
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: backColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: backColor))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomPopup() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              color: backColor,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(Icons.delete,color: Colors.white,),
                  ),
                  ListTile(
                    title: Text('Make a copy',
                      style: TextStyle(color: Colors.white),),
                    leading: Icon(Icons.content_copy,color: Colors.white,),
                  ),
                  ListTile(
                    title: Text('Send',
                      style: TextStyle(color: Colors.white),),
                    leading: Icon(Icons.share,color: Colors.white,),
                  ),
                  ListTile(
                    title: Text('Collaborator',
                      style: TextStyle(color: Colors.white),),
                    leading: Icon(Icons.person_add,color: Colors.white,),
                  ),
                  ListTile(
                    title: Text('Label',
                      style: TextStyle(color: Colors.white),),
                    leading: Icon(Icons.label,color: Colors.white,),
                  )
                ],
              ));
        });
  }
}
