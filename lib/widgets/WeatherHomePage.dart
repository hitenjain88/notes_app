import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  Widget weatherWidget;
  String pinCode;
  String countryCode;
  String cityName;
  TextEditingController cityNameController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  final response =
      FirebaseDatabase.instance.reference().child('Users').child('user1');
  User user = User();

  @override
  void initState() {
    super.initState();
    weatherWidget = WeatherOldLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        padding: EdgeInsets.all(10.0),
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
        child: Column(
          children: <Widget>[
            Expanded(child: weatherWidget),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        weatherWidget = WeatherCurrentLocation();
                      });
                    },
                    child: Text('Location'),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      pinCodeController.text = '';
                      countryCodeController.text = '';
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertPincode();
                          });
                    },
                    child: Text('Pincode/Postal-Code'),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      cityNameController.text = '';
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertCity();
                          });
                    },
                    child: Text('City Name'),
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget displayWeather(weatherStatus) {
    return Column(children: <Widget>[
      Align(
        alignment: Alignment.centerRight,
        child: Text(
            'Last Updated: ${weatherStatus['lastUpdated']['date']}, ${weatherStatus['lastUpdated']['time']}'),
      ),
      Align(
          alignment: Alignment.centerLeft,
          child: Text('${weatherStatus['weather']['name']}')),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
            'Current Temperature is ${weatherStatus['weather']['main']['temp'] - 273}\u1d52C'),
      ),
      Align(
          alignment: Alignment.centerLeft,
          child: Text('${weatherStatus['weather']['weather'][0]['main']}')),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                  'Min. Temp: ${weatherStatus['weather']['main']['temp_min']}'),
              Text(
                  'Max. Temp: ${weatherStatus['weather']['main']['temp_max']}'),
            ],
          ),
          Column(
            children: <Widget>[
              Text('Pressure: ${weatherStatus['weather']['main']['pressure']}'),
              Text('Humidity: ${weatherStatus['weather']['main']['humidity']}'),
              Text('Wind: ${weatherStatus['weather']['wind']['speed']}'),
            ],
          )
        ],
      )
    ]);
  }

  Widget AlertPincode() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Weather from Pincode/Postal-Code',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: pinCodeController,
              decoration: InputDecoration(
                labelText: 'Enter Your Pincode',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(27.0),
                        bottomRight: Radius.circular(27.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(27.0),
                        bottomRight: Radius.circular(27.0))),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextField(
              controller: countryCodeController,
              decoration: InputDecoration(
                labelText: 'Enter Your Country Code',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(27.0),
                        bottomRight: Radius.circular(27.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(27.0),
                        bottomRight: Radius.circular(27.0))),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.25,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.015),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF10316b)),
                    borderRadius: BorderRadius.circular(30.0)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.cancel),
                      Expanded(child: Text('Cancel'))
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.25,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.01,
                    top: MediaQuery.of(context).size.height * 0.015),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF10316b)),
                    borderRadius: BorderRadius.circular(30.0)),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      pinCode = pinCodeController.text;
                      countryCode = countryCodeController.text;
                      weatherWidget = WeatherPincode();
                    });
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.check_circle_outline),
                      Expanded(child: Text('Confirm'))
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget AlertCity() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Weather from Pincode/Postal-Code',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextField(
              controller: cityNameController,
              decoration: InputDecoration(
                labelText: 'Enter Your City Name',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(27.0),
                        bottomRight: Radius.circular(27.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(27.0),
                        bottomRight: Radius.circular(27.0))),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.25,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.015),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF10316b)),
                    borderRadius: BorderRadius.circular(30.0)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.cancel),
                      Expanded(child: Text('Cancel'))
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.25,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.01,
                    top: MediaQuery.of(context).size.height * 0.015),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF10316b)),
                    borderRadius: BorderRadius.circular(30.0)),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      cityName = cityNameController.text;
                      weatherWidget = WeatherCityName();
                    });
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.check_circle_outline),
                      Expanded(child: Text('Confirm'))
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget WeatherPincode() {
    var weatherStatus;
    return FutureBuilder(
      future: getWeatherPincode(pinCode, countryCode),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          weatherStatus = snapshot.data;
          print(weatherStatus);
          return displayWeather(weatherStatus);
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

  Future getWeatherPincode(pincode, countryCode) async {
    Map weatherStatus = {};
    var dataString =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');
    var dataJson = json.decode(dataString.toString());
    String url =
        'http://api.openweathermap.org/data/2.5/weather?zip=$pincode,$countryCode&appid=${dataJson["weatherApiKey"]}';
    http.Response res = await http.get(url);
    var weather = json.decode(res.body);
    weatherStatus['weather'] = weather;
    var dateTime = getCurrentTime();
    weatherStatus['lastUpdated'] = dateTime;
    weatherData.writeFile(weatherStatus);
    return weatherStatus;
  }

  Widget WeatherCityName() {
    var weatherStatus;
    return FutureBuilder(
      future: getWeatherCityName(cityName.toLowerCase()),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          weatherStatus = snapshot.data;
          return displayWeather(weatherStatus);
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

  Future getWeatherCityName(cityName) async {
    Map weatherStatus = {};
    var dataString =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');
    var dataJson = json.decode(dataString.toString());
    String url =
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=${dataJson["weatherApiKey"]}';
    http.Response res = await http.get(url);
    var weather = json.decode(res.body);
    weatherStatus['weather'] = weather;
    var dateTime = getCurrentTime();
    weatherStatus['lastUpdated'] = dateTime;
    weatherData.writeFile(weatherStatus);
    return weatherStatus;
  }

  Widget WeatherOldLocation() {
    var previousWeather;
    return FutureBuilder(
      future: weatherData.readFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data;
          if (data == 'file does not exist') {
            return Center(
              child: Text('Click on one of the below button to check weather'),
            );
          } else {
            previousWeather = jsonDecode(snapshot.data);
            return displayWeather(previousWeather);
          }
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
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          weatherStatus = snapshot.data;
          if (weatherStatus['permissionStatus']) {
            if (weatherStatus['locationStatus']) {
              return displayWeather(weatherStatus);
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
      if (locationPermissionGranted == PermissionStatus.denied) {
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
        weatherDetails = await getWeatherCurrent(
            locationData.latitude, locationData.longitude);
        response.update({
          'latitude': locationData.latitude,
          'longitude': locationData.longitude
        });
        weatherStatus['weather'] = weatherDetails;
        var dateTime = getCurrentTime();
        weatherStatus['lastUpdated'] = dateTime;
        weatherData.writeFile(weatherStatus);
      }
    }
    return weatherStatus;
  }

  Future getWeatherCurrent(latitude, longitude) async {
    var dataString =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');
    var dataJson = json.decode(dataString.toString());
    String url =
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${dataJson["weatherApiKey"]}';
    http.Response res1 = await http.get(url);
    var weather = json.decode(res1.body);
    return weather;
  }

  getCurrentTime() {
    Map dateTime = {};
    var currentTime = DateTime.now();
    String date = DateFormat.yMMMEd().format(currentTime);
    String time = DateFormat.jm().format(currentTime);
    dateTime['date'] = date;
    dateTime['time'] = time;
    return dateTime;
  }
}
