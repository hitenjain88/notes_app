import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:notesapp/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:notesapp/storage/WeatherData.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WeatherHomePageState();
  }
}

class WeatherHomePageState extends State<WeatherHomePage> {
  Location location = Location();
  WeatherData weatherData = WeatherData();
  PermissionStatus locationPermissionGranted;
  bool locationServiceEnabled;
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
                user.longitude = values['longitude'].toDouble();
                user.latitude = values['latitude'].toDouble();
              }
              return (user.longitude == -1.0 || user.latitude == -1.0)
                  ? Center(
                      child: Text("There's no previous location for weather"))
                  : WeatherOldLocation();
            }
            return Container(
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.1,
                child: Center(child: CircularProgressIndicator()));
          },
        ));
  }

  Widget WeatherOldLocation() {
    var previousWeather;
    return FutureBuilder(
      future: weatherData.readFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          previousWeather = jsonDecode(snapshot.data);
          return Center(
              child: Text(
                  'Previous Temperature is ${previousWeather['main']['temp'] - 273}\u1d52C'));
        }
        return Container(
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.1,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget WeatherCurrentLocation() {
    var weatherStatus;
    return FutureBuilder(
      future: getCoordinates(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          weatherStatus = snapshot.data;
          if (weatherStatus['permissionStatus']) {
            if (weatherStatus['locationStatus']) {
              return Center(
                child: Text(
                    'Current Temperature is ${weatherStatus['weather']['main']['temp'] - 273}\u1d52C'),
              );
            } else {
              return Center(child: Text('location is off'));
            }
          } else {
            return Center(child: Text('permission not granted'));
          }
        }
        return Container(
            height: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Future getCoordinates() async {
    var weatherDetails;
    Map weatherStatus = {};
    locationPermissionGranted = await location.hasPermission();
    if (locationPermissionGranted == PermissionStatus.denied) {
      locationPermissionGranted = await location.requestPermission();
      if (locationPermissionGranted ==PermissionStatus.denied) {
        weatherStatus['permissionStatus'] = false;
      }
    }
    if (locationPermissionGranted == PermissionStatus.granted) {
      weatherStatus['permissionStatus'] = true;
      locationServiceEnabled = await location.serviceEnabled();
      if (!locationServiceEnabled) {
        locationServiceEnabled = await location.requestService();
        if (!locationServiceEnabled) {
          weatherStatus['locationStatus'] = false;
        }
      }
      if (locationServiceEnabled) {
        weatherStatus['locationStatus'] = true;
        locationData = await location.getLocation();
        weatherDetails =
            await getWeather(locationData.latitude, locationData.longitude);
        weatherData.writeFile(weatherDetails);
        response.update({
          'latitude': locationData.latitude,
          'longitude': locationData.longitude
        });
        weatherStatus['weather'] = weatherDetails;
      }
    }
    return weatherStatus;
  }

  Future getWeather(latitude, longitude) async {
    var dataString =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');
    var dataJson = json.decode(dataString.toString());
    http.Response res = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?zip=121006,in&appid=${dataJson["weatherApiKey"]}');
    var weather = json.decode(res.body);
    return weather;
  }
}
