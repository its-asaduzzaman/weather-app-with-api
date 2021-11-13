import 'package:flutter/material.dart';
import 'package:weather/utilities/constants.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/screens/error_page.dart';
import 'package:weather/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String countryName;
  late double wind;
  late String weatherMessage;
  late int humidity;
  late int pressure;
  late String cityName;
  late int visibility;
  late double feelLike;
  late String description;
  late double tempMin;
  late double tempMax;
  late String weatherMainName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
// weatherData = null;
    setState(() {
      if (weatherData == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ErrorPage();
        }));
        return;
      } else {
        double temp = weatherData['main']['temp'];
        temperature = temp.ceil();
        weatherMessage = weather.getMessage(temperature);
        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weather.getWeatherIcon(condition);
        countryName = weatherData['sys']['country'];
        wind = weatherData['wind']['speed'];
        humidity = weatherData['main']['humidity'];
        pressure = weatherData['main']['pressure'];
        cityName = weatherData['name'];
        visibility = weatherData['visibility'];
        feelLike = weatherData['main']['feels_like'];
        description = weatherData['weather'][0]['description'];
        tempMax = weatherData['main']['temp_min'];
        tempMin = weatherData['main']['temp_max'];
        weatherMainName = weatherData['weather'][0]['main'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 15.5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '$cityName, $countryName',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${(temperature)}°C',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      weatherIcon,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.5,
              ),
              Text(
                "Feel like ${(feelLike).ceil()}°C, $description and \n $weatherMessage in $cityName .",
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 60.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.black38,
                ),
                padding: EdgeInsets.only(top: 20.0, left: 45.0, right: 35.0),
                width: double.infinity,
                height: 110.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Max: ${((tempMax)).ceil()}°C",
                          style: kWeatherOtherInfoStyle,
                        ),
                        Text("Min: ${((tempMin)).round()}°C ",
                            textAlign: TextAlign.left,
                            style: kWeatherOtherInfoStyle),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Wind: ${wind}m/s ",
                          style: kWeatherOtherInfoStyle,
                        ),
                        Text(
                          "Pressure: ${pressure}hPa ",
                          textAlign: TextAlign.start,
                          style: kWeatherOtherInfoStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Humidity: $humidity% ",
                          style: kWeatherOtherInfoStyle,
                        ),
                        Text(
                            "Visibility: ${((visibility) / 1000)..toStringAsFixed(2)}Km ",
                            textAlign: TextAlign.right,
                            style: kWeatherOtherInfoStyle),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        weatherIcon,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 150.0,
                            color: Colors.white.withOpacity(.6)),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        weatherMainName.toUpperCase(),
                        style: TextStyle(
                            letterSpacing: 8,
                            fontSize: 22.0,
                            color: Colors.black.withOpacity(.6),
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        setState(() async {
                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                        });
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                        color: Colors.pink,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
