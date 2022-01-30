import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class AppUtils {
  static Map<String, Color> iconColorMap = {
    "Wind": Color(0xff85b198),
    "Humidity": Color(0xff85c6dd),
    "Pressure": Color(0xffe8a69a)
  };

  static Map<String, Color> boxColorMap = {
    "Wind": Color(0xffe7f5e7),
    "Humidity": Color(0xffe0eff6),
    "Pressure": Color(0xfff4d9c2)
  };

  static Map<String, IconData> iconMap = {
    "Wind": WeatherIcons.strong_wind,
    "Humidity": WeatherIcons.humidity,
    "Pressure": WeatherIcons.barometer
  };
}
