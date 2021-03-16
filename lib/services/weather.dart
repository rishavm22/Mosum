import 'package:Mosum/services/location.dart';
import 'package:Mosum/services/networking.dart';
import 'package:flutter/cupertino.dart';

const apiKey = '×××××××××××';

class WeatherModel {

  Future<dynamic> getLocationWeather(String cityName) async{
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCurrentLocationWeather() async{
    Location loc = Location();
    loc.getPermission();
    await loc.getLocation();
    String lat = loc.latitude.toString();
    String lon = loc.longitude.toString();
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  AssetImage getBackground(int temp, int condition) {
    if (temp > 20) {
      return AssetImage('images/summer.jpg');
    } else if (temp < 10) {
      return AssetImage('images/cold.jpg');
    } else if (condition < 300) {
      return AssetImage('images/lightning.jpg');
    } else if (condition < 400) {
      return AssetImage('images/rain.jpg');
    } else {
      return AssetImage('images/background.jpg');
    }
  }
}
