import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/models/User.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WeatherHomePageState();
  }
}

class WeatherHomePageState extends State<WeatherHomePage> {
  final response=FirebaseDatabase.instance.reference().child('Users').child('user1');
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                offset: Offset(0.3, 0.3),
                color: Colors.black87,
                blurRadius: 5.0)
          ]),
      child: FutureBuilder(
        future: response.once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
          if (snapshot.hasData){
            Map<dynamic, dynamic> values = snapshot.data.value;
            if (values != null) {
              user.longitude=values['longitude'];
              user.latitude=values['latitude'];
            }
            return (user.longitude == 'none' || user.latitude == 'none')
                ? Center(child: Text("There's no location for weather"))
                : Center(
                child: Text("Fetching Weather Details for Previous Location"));
        }
          return CircularProgressIndicator();
        },
      )
    );
  }
}
