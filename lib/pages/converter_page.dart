import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> _area = [
  "Square Kilometer",
  "Square Meter",
  "Square Mile",
  "Square Yard",
  "Square Foot",
  "Square Inch",
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
  "Fahrenheit",
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

class ConverterPage extends StatefulWidget {
  final String quantityName;
  const ConverterPage({
    Key? key,
    required this.quantityName,
  }) : super(key: key);

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  int _listIndex = 0;
  void _showSlider(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(
          context,
        ),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String quantityName = widget.quantityName;
    int length = (quantityName == "Area")
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
    List<String> list = (quantityName == "Area")
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
    String background = (quantityName == "Area")
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

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/converterpage_backgrounds/$background.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(quantityName),
                  CupertinoButton(
                    onPressed: () => _showSlider(
                      CupertinoPicker(
                        itemExtent: 45,
                        onSelectedItemChanged: (int selectedItem) {
                          setState(
                            () {
                              _listIndex = selectedItem;
                            },
                          );
                        },
                        children: List<Widget>.generate(
                          length,
                          (int index) {
                            return Center(
                              child: Text(
                                list[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    child: Text(
                      list[_listIndex],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
