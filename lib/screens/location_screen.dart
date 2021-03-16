import 'package:Mosum/screens/city_screen.dart';
import 'package:Mosum/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:Mosum/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temp;
  String weatherIcon;
  String message;
  String weather;
  String desc;
  int feelsLike;
  int tempMin;
  int tempMax;
  int humidity;
  int pressure;
  String cityName;
  AssetImage backImage = AssetImage('images/background.jpg');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic decodedData) {
    if (decodedData == null) {
      temp = 0;
      feelsLike = 0;
      tempMin = 0;
      tempMax = 0;
      message = "Network Issue";
      return;
    }
    // print(decodedData);
    setState(() {
      weather = decodedData['weather'][0]['main'];
      desc = decodedData['weather'][0]['description'];
      var condition = decodedData['weather'][0]['id'];
      temp = decodedData['main']['temp'].toInt();
      feelsLike = decodedData['main']['feels_like'].toInt();
      tempMin = decodedData['main']['temp_min'].toInt();
      tempMax = decodedData['main']['temp_max'].toInt();
      pressure = decodedData['main']['pressure'];
      humidity = decodedData['main']['humidity'];

      cityName = decodedData['name'];
      backImage = weatherModel.getBackground(temp, condition);
      weatherIcon = weatherModel.getWeatherIcon(condition);
      message = weatherModel.getMessage(temp);
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backImage,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData =
                          await weatherModel.getCurrentLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if(cityName!=null){
                        var weatherData = await weatherModel.getLocationWeather(cityName);
                        // print(weatherData);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Min $tempMin°   Max $tempMax°',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'Feels Like $feelsLike°',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Pressure $pressure',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'Humidity $humidity',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
