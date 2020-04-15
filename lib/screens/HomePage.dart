import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:notesapp/widgets/WeatherHomePage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
//  Location location = new Location();
//
//  bool _serviceEnabled;
//  PermissionStatus _permissionGranted;
//  LocationData _locationData;
//
//  Future abc() async {
//    _serviceEnabled = await location.serviceEnabled();
//    if (!_serviceEnabled) {
//      _serviceEnabled = await location.requestService();
//      if (!_serviceEnabled) {
//        return;
//      }
//    }
//    _locationData = await location.getLocation();
//    print(_locationData.longitude);
//  }
//
//  Future xyz() async {
//    _permissionGranted = await location.hasPermission();
//    if (_permissionGranted == PermissionStatus.denied) {
//      _permissionGranted = await location.requestPermission();
//      if (_permissionGranted != PermissionStatus.granted) {
//        return;
//      }
//    }
//  }
//
//  final Geolocator geolocator=Geolocator()..forceAndroidLocationManager;
//
//  Position currentPosition;
//  String currentAddress;
//
//  @override
//  void initState() {
//    super.initState();
//    //getCurrentLocation();
//    //weather();
//    abc();
//  }
//
//  getCurrentLocation(){
//    print('1');
//    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position){
//      print('2');
//      currentPosition=position;
//      print(currentPosition);
//      getAddressFromLatLng();
//    }).catchError((e){
//      print(e);
//    });
//  }
//
//  getAddressFromLatLng() async {
//    try{
//      List<Placemark> p= await geolocator.placemarkFromCoordinates(currentPosition.latitude,currentPosition.longitude);
//      Placemark place=p[0];
//      currentAddress='${place.locality},${place.postalCode},${place.country}';
//      print(currentAddress);
//    }catch(e){
//      print(e);
//    }
//  }
//
//  Future weather() async {
//    http.Response res = await http.get(
//        'http://api.openweathermap.org/data/2.5/weather?zip=121006,in&appid=8eef57813fa055dcfbe6d722787a1ad7');
//    var data=json.decode(res.body);
//    print(data['main']['temp']);
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: WeatherHomePage()
    );
  }
}
