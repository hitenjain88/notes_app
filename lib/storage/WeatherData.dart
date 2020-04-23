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
    String contents;
    try{
      final file=await localFile;
      if (await file.exists()){
        contents=await file.readAsString();
      }
      else{
        contents='file does not exist';
      }
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