import 'package:flutter/rendering.dart';

const List<String> _area = [
  "Square Kilometer",
  "Square Meter",
  "Square Mile",
  "Hectare",
  "Acre",
];
const List<String> _time = [
  "Millisecond",
  "Second",
  "Minute",
  "Hour",
  "Day",
  "Week",
];
const List<String> _volume = [
  "Cubic Meter",
  "Cubic Centimeter",
  "Mililiter",
  "Liter",
];

const List<String> _temperature = [
  "Celcius",
  "Fahreinheit",
  "Kelvin",
];

const List<String> _length = [
  "Kilometer",
  "Meter",
  "Centimeter",
  "Millimeter",
  "Mile",
  "Yard",
  "Foot",
  "Inch",
];

const List<String> _speed = [
  "Meter per second",
  "Kilometer per hour",
  "Miles per hour",
  "Knot",
];

class Data {
  final String quantityName;
  const Data({
    required this.quantityName,
  });

  int length() {
    return (quantityName == "Area")
        ? _area.length
        : (quantityName == "Time")
            ? _time.length
            : (quantityName == "Volume")
                ? _volume.length
                : (quantityName == "Temperature")
                    ? _temperature.length
                    : (quantityName == "Length")
                        ? _length.length
                        : _speed.length;
  }

  List<String> list() {
    return (quantityName == "Area")
        ? _area
        : (quantityName == "Time")
            ? _time
            : (quantityName == "Volume")
                ? _volume
                : (quantityName == "Temperature")
                    ? _temperature
                    : (quantityName == "Length")
                        ? _length
                        : _speed;
  }

  String background() {
    return (quantityName == "Area")
        ? "area"
        : (quantityName == "Time")
            ? "time"
            : (quantityName == "Volume")
                ? "volume"
                : (quantityName == "Temperature")
                    ? "temperature"
                    : (quantityName == "Length")
                        ? "length"
                        : "speed";
  }

  Color quantityNameColor() {
    return (quantityName == "Area")
        ? const Color.fromRGBO(124, 83, 254, 1)
        : (quantityName == "Time")
            ? const Color.fromRGBO(255, 63, 191, 1)
            : (quantityName == "Volume")
                ? const Color.fromRGBO(255, 136, 54, 1)
                : (quantityName == "Temperature")
                    ? const Color.fromRGBO(77, 123, 255, 1)
                    : (quantityName == "Length")
                        ? const Color.fromRGBO(51, 169, 191, 1)
                        : const Color.fromRGBO(46, 222, 97, 1);
  }
}
