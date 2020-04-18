import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class WeatherData{
  Future<String> get localPath async{
    final directory=await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async{
    final path=await localPath;
    return File('$path/weather.json');
  }

  Future<String> readFile() async{
    try{
      final file=await localFile;
      String contents=await file.readAsString();
      return contents;
    }
    catch (e){
      return e;
    }
  }

  Future<File> writeFile(weather) async {
    final file=await localFile;
    return file.writeAsString(json.encode(weather));
  }
}