import 'package:Mosum/screens/location_screen.dart';
import 'package:Mosum/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  String long,lat;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future<void> getLocation() async {

    var weatherData = await WeatherModel().getCurrentLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      // print(weatherData);
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));

  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.white,
          size: 55,
        ),
      ),
    );
  }
}

