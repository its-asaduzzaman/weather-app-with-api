import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';

const apiKey = '7904a67856d292ac96f26e994effae02';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future <dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapUrl?lat=${(location.latitude).toStringAsPrecision(3)}&lon=${(location.longitude.toStringAsPrecision(3))}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ';
    } else if (condition < 700) {
      return 'โ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return '๐';
    } else if (condition <= 804) {
      return 'โ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 30) {
      return 'It\'s ๐ฆ time';
    } else if (temp >= 28) {
      return 'Time for shorts and ๐';
    } else if (temp <= 19) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
