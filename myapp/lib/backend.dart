import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;


class Location{

  static Future<Data> getCurrentLocation(String city) async{
    Data data = Data(100, -1, 'Phone');

    LocationPermission check = await Geolocator.checkPermission();
    
    if(check == LocationPermission.denied || check == LocationPermission.unableToDetermine){
      await Geolocator.requestPermission();
    }
    
    try{
      Position location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low
      );
      
      data = await NetworkHelper._getData(city, location.latitude, location.longitude) ?? data;

    }catch(exception){
      log(exception.toString());
    }

    return data;
  }
}


class NetworkHelper{
  static Future<Data?> _getData(String place, double lat, double long) async{
    const apiKey = '20a15b9b80162b6145f2ffe4492501b3';
    
    String cityurl = 'https://api.openweathermap.org/data/2.5/weather?q=$place&appid=$apiKey&units=metric';
    String locurl = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric';

    String url = cityurl;

    if(place == ''){
      url = locurl;
    }
    
    Data? data;
    
    try{
      http.Response response = await http.get(
        Uri.parse(url));
      
      if(response.statusCode == 200){
        data = Data.fromJson(jsonDecode(response.body));
      }
      else{
        log('Error occured in the Weather API');
      }

    }catch(exception){
      log(exception.toString());
    }

    return data;
  }
}

class Data{
  int temparature;
  int weatherid;
  String city;

  Data(this.temparature, this.weatherid, this.city);

  Data.fromJson(Map<String, dynamic> data):
    temparature = (data['main']['temp']).round(),
    weatherid = data['weather'][0]['id'],
    city = data['name'];

}