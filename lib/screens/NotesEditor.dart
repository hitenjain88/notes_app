import 'package:flutter/material.dart';

class NotesEditor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotesEditorState();
  }
}

class NotesEditorState extends State<NotesEditor> {
  Color backColor = Color(0xFF000000);
  List<Color> backColorList = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Color(0xff00008b),
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.grey
  ];

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add_box),
                color: Colors.white,
                onPressed: () {
                  showBottomPopupLeft(context);
                },
                iconSize: 20.0,
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                color: Colors.white,
                onPressed: () {
                  showBottomPopupRight(context);
                },
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

  void showBottomPopupRight(context) {
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
                    leading: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Make a copy',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.content_copy,
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Send',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Collaborator',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.person_add,
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Label',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.label,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: backColorList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                backColor = backColorList[index];
                              });
                              Navigator.pop(context);
                              showBottomPopupRight(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: backColorList[index]),
                            ),
                          );
                        }),
                  )
                ],
              ));
        });
  }

  void showBottomPopupLeft(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              color: backColor,
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: ListView(children: <Widget>[
                ListTile(
                  title: Text(
                    'Take photo',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.photo_camera,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Choose image',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Drawing',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.brush,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Recording',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.mic,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Tick boxes',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.check_box,
                    color: Colors.white,
                  ),
                )
              ]));
        });
  }
}
