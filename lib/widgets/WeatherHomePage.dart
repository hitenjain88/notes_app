import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:notesapp/models/User.dart';
import 'package:http/http.dart' as http;

class WeatherHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WeatherHomePageState();
  }
}

class WeatherHomePageState extends State<WeatherHomePage> {
  Location location = new Location();
  PermissionStatus permissionGranted;
  bool serviceEnabled;
  LocationData locationData;
  final response =
      FirebaseDatabase.instance.reference().child('Users').child('user1');
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
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> values = snapshot.data.value;
              if (values != null) {
                user.longitude = values['longitude'];
                user.latitude = values['latitude'];
              }
              return (user.longitude == 'none' || user.latitude == 'none')
                  ? Center(child: Text("There's no previous location for weather"))
                  : WeatherOldLocation();
            }
            return Container(
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.1,
                child: Center(child: CircularProgressIndicator()));
          },
        ));
  }

  Widget WeatherOldLocation(){
    return FutureBuilder(
      future: getCoordinates(),
      builder: (context, snapshot){
        return Container(
            height: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Future getCoordinates() async {
    String locationStatus;
    String permissionStatus;
    permissionGranted=await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied){
      print(1);
      permissionGranted=await location.requestPermission();
      if (permissionGranted==PermissionStatus.denied){
        permissionStatus='denied';
      }
    }
    if (permissionGranted==PermissionStatus.granted){
      print(2);
      permissionStatus='granted';
      serviceEnabled = await location.serviceEnabled();
      if(!serviceEnabled){
        serviceEnabled=await location.requestService();
        if (!serviceEnabled){
          locationStatus='off';
        }
      }
      if (serviceEnabled){
        locationStatus='on';
        locationData=await location.getLocation();
        getWeather(locationData.latitude, locationData.longitude);
      }
    }
    return locationStatus;
  }

  Future getWeather(latitude,longitude) async {
    http.Response res = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?zip=121006,in&appid=');
    var data=json.decode(res.body);
    print(data['main']['temp']-273);
  }
}
