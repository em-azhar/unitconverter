import 'dart:math';

class Conversion {
  num areaResult(num value, String toBeConvertedUnit, String convertedUnit,
      String quantityName) {
    num result = 0;

    if (quantityName == "Area") {
      if (toBeConvertedUnit == "Square Kilometer") {
        result = (convertedUnit == "Square Meter")
            ? value * 1000000
            : (convertedUnit == "Square Mile")
                ? value / 2.59
                : (convertedUnit == "Hectare")
                    ? value * 100
                    : (convertedUnit == "Acre")
                        ? value * 247.1
                        : value;
      } else if (toBeConvertedUnit == "Square Meter") {
        result = (convertedUnit == "Square Kilometer")
            ? value / 1000000
            : (convertedUnit == "Square Mile")
                ? value / 2.59 * 1000000
                : (convertedUnit == "Hectare")
                    ? value / 10000
                    : (convertedUnit == "Acre")
                        ? value / 4047
                        : value;
      } else if (toBeConvertedUnit == "Square Mile") {
        result = (convertedUnit == "Square Kilometer")
            ? value * 2.59
            : (convertedUnit == "Square Meter")
                ? value * 2.59 * 1000000
                : (convertedUnit == "Hectare")
                    ? value * 259
                    : (convertedUnit == "Acre")
                        ? value * 640
                        : value;
      } else if (toBeConvertedUnit == "Hectare") {
        result = (convertedUnit == "Square Kilometer")
            ? value / 100
            : (convertedUnit == "Square Meter")
                ? value * 10000
                : (convertedUnit == "Square Mile")
                    ? value / 259
                    : (convertedUnit == "Acre")
                        ? value * 11960
                        : value;
      } else if (toBeConvertedUnit == "Acre") {
        result = (convertedUnit == "Square Kilometer")
            ? value / 247.1
            : (convertedUnit == "Square Meter")
                ? value * 4047
                : (convertedUnit == "Square Mile")
                    ? value / 640
                    : (convertedUnit == "Hectare")
                        ? value * 4840
                        : value;
      } else {
        result = value;
      }
    } else if (quantityName == "Time") {
      if (toBeConvertedUnit == "Millisecond") {
        result = (convertedUnit == "Second")
            ? value / 1000
            : (convertedUnit == "Minute")
                ? value / 60000
                : (convertedUnit == "Hour")
                    ? value / 3.6 * pow(10, 6)
                    : (convertedUnit == "Day")
                        ? value / 8.64 * pow(10, 7)
                        : value;
      } else if (toBeConvertedUnit == "Second") {
        result = (convertedUnit == "Millisecond")
            ? value * 1000
            : (convertedUnit == "Minute")
                ? value / 60
                : (convertedUnit == "Hour")
                    ? value / 3600
                    : (convertedUnit == "Day")
                        ? value / 86400
                        : value;
      } else if (toBeConvertedUnit == "Minute") {
        result = (convertedUnit == "Millisecond")
            ? value * 60000
            : (convertedUnit == "Second")
                ? value * 60
                : (convertedUnit == "Hour")
                    ? value / 60
                    : (convertedUnit == "Day")
                        ? value / 1440
                        : value;
      } else if (toBeConvertedUnit == "Hour") {
        result = (convertedUnit == "Millisecond")
            ? value * 3.6 * pow(10, 6)
            : (convertedUnit == "Second")
                ? value * 3600
                : (convertedUnit == "Minute")
                    ? value * 60
                    : (convertedUnit == "Day")
                        ? value / 24
                        : value;
      } else if (toBeConvertedUnit == "Day") {
        result = (convertedUnit == "Millisecond")
            ? value * 8.64 * pow(10, 7)
            : (convertedUnit == "Second")
                ? value * 86400
                : (convertedUnit == "Minute")
                    ? value * 1440
                    : (convertedUnit == "Hour")
                        ? value * 24
                        : value;
      } else {
        result = value;
      }
    } else if (quantityName == "Volume") {
      if (toBeConvertedUnit == "Cubic Meter") {
        result = (convertedUnit == "Mililiter")
            ? value * 1000000
            : (convertedUnit == "Liter")
                ? value * 1000
                : value;
      } else if (toBeConvertedUnit == "Mililiter") {
        result = (convertedUnit == "Cubic Meter")
            ? value / 1000000
            : (convertedUnit == "Liter")
                ? value / 1000
                : value;
      } else if (toBeConvertedUnit == "Liter") {
        result = (convertedUnit == "Cubic Meter")
            ? value / 1000
            : (convertedUnit == "Mililiter")
                ? value * 1000
                : value;
      } else {
        result = value;
      }
    } else if (quantityName == "Temperature") {
      if (toBeConvertedUnit == "Celcius") {
        result = (convertedUnit == "Fahreinheit")
            ? ((value * 9) + 160) / 5
            : (convertedUnit == "Kelvin")
                ? value + 273.15
                : value;
      } else if (toBeConvertedUnit == "Fahreinheit") {
        result = (convertedUnit == "Celcius")
            ? ((value * 5) - 160) / 9
            : (convertedUnit == "Kelvin")
                ? ((value * 5) + 2258.35) / 9
                : value;
      } else if (toBeConvertedUnit == "Kelvin") {
        result = (convertedUnit == "Fahreinheit")
            ? ((value * 9) - 2258.35) / 5
            : (convertedUnit == "Celcius")
                ? value - 273.15
                : value;
      } else {
        result = value;
      }
    } else if (quantityName == "Length") {
      if (toBeConvertedUnit == "Kilometer") {
        result = (convertedUnit == "Meter")
            ? value * 1000
            : (convertedUnit == "Mile")
                ? value / 1.609
                : (convertedUnit == "Centimeter")
                    ? value * 100000
                    : (convertedUnit == "Millimeter")
                        ? value * 1000000
                        : (convertedUnit == "Yard")
                            ? value * 1093.61
                            : (convertedUnit == "Foot")
                                ? value * 3280.84
                                : (convertedUnit == "Inch")
                                    ? value * 39370.1
                                    : value;
      } else if (toBeConvertedUnit == "Meter") {
        result = (convertedUnit == "Kilometer")
            ? value / 1000
            : (convertedUnit == "Mile")
                ? value / 1609
                : (convertedUnit == "Centimeter")
                    ? value * 100
                    : (convertedUnit == "Millimeter")
                        ? value * 1000
                        : (convertedUnit == "Yard")
                            ? value * 1.09361
                            : (convertedUnit == "Foot")
                                ? value * 3.28084
                                : (convertedUnit == "Inch")
                                    ? value * 39.3709
                                    : value;
      } else if (toBeConvertedUnit == "Centimeter") {
        result = (convertedUnit == "Meter")
            ? value / 100
            : (convertedUnit == "Mile")
                ? value / 160900
                : (convertedUnit == "Kilometer")
                    ? value / 100000
                    : (convertedUnit == "Millimeter")
                        ? value * 10
                        : (convertedUnit == "Yard")
                            ? value / 91.44
                            : (convertedUnit == "Foot")
                                ? value / 30.48
                                : (convertedUnit == "Inch")
                                    ? value / 2.54
                                    : value;
      } else if (toBeConvertedUnit == "Millimeter") {
        result = (convertedUnit == "Meter")
            ? value / 1000
            : (convertedUnit == "Mile")
                ? value / 1.609 * pow(10, 6)
                : (convertedUnit == "Centimeter")
                    ? value / 10
                    : (convertedUnit == "Kilometer")
                        ? value / 1000
                        : (convertedUnit == "Yard")
                            ? value / 914.4
                            : (convertedUnit == "Foot")
                                ? value / 304.8
                                : (convertedUnit == "Inch")
                                    ? value / 25.4
                                    : value;
      } else if (toBeConvertedUnit == "Mile") {
        result = (convertedUnit == "Meter")
            ? value * 1609.34
            : (convertedUnit == "Kilometer")
                ? value * 1.609
                : (convertedUnit == "Centimeter")
                    ? value * 160900
                    : (convertedUnit == "Millimeter")
                        ? value * 1.609 * pow(10, 6)
                        : (convertedUnit == "Yard")
                            ? value * 1760
                            : (convertedUnit == "Foot")
                                ? value * 5280
                                : (convertedUnit == "Inch")
                                    ? value * 63360
                                    : value;
      } else if (toBeConvertedUnit == "Yard") {
        result = (convertedUnit == "Meter")
            ? value / 1.094
            : (convertedUnit == "Mile")
                ? value / 1760
                : (convertedUnit == "Centimeter")
                    ? value * 91.44
                    : (convertedUnit == "Millimeter")
                        ? value * 914.4
                        : (convertedUnit == "Kilometer")
                            ? value / 1094
                            : (convertedUnit == "Foot")
                                ? value * 3
                                : (convertedUnit == "Inch")
                                    ? value * 36
                                    : value;
      } else if (toBeConvertedUnit == "Foot") {
        result = (convertedUnit == "Meter")
            ? value / 3.281
            : (convertedUnit == "Mile")
                ? value / 5280
                : (convertedUnit == "Centimeter")
                    ? value * 30.48
                    : (convertedUnit == "Millimeter")
                        ? value * 304.8
                        : (convertedUnit == "Yard")
                            ? value / 3
                            : (convertedUnit == "Kilometer")
                                ? value / 3281
                                : (convertedUnit == "Inch")
                                    ? value * 12
                                    : value;
      } else if (toBeConvertedUnit == "Inch") {
        result = (convertedUnit == "Meter")
            ? value / 39.37
            : (convertedUnit == "Mile")
                ? value / 63360
                : (convertedUnit == "Centimeter")
                    ? value * 2.54
                    : (convertedUnit == "Millimeter")
                        ? value * 25.4
                        : (convertedUnit == "Yard")
                            ? value / 36
                            : (convertedUnit == "Foot")
                                ? value / 12
                                : (convertedUnit == "Kilometer")
                                    ? value / 247.1
                                    : value;
      } else {
        result = value;
      }
    } else if (quantityName == "Speed") {
      if (toBeConvertedUnit == "Meter per second") {
        result = (convertedUnit == "Kilometer per hour")
            ? value * 3.6
            : (convertedUnit == "Mile per hour")
                ? value * 2.237
                : (convertedUnit == "Knot")
                    ? value * 1.944
                    : value;
      } else if (toBeConvertedUnit == "Kilometer per hour") {
        result = (convertedUnit == "Meter per second")
            ? value / 3.6
            : (convertedUnit == "Mile per hour")
                ? value / 1.609
                : (convertedUnit == "Knot")
                    ? value / 1.852
                    : value;
      } else if (toBeConvertedUnit == "Miles per hour") {
        result = (convertedUnit == "Kilometer per hour")
            ? value * 1.609
            : (convertedUnit == "Meter per second")
                ? value / 2.59
                : (convertedUnit == "Knot")
                    ? value / 1.151
                    : value;
      } else if (toBeConvertedUnit == "Knot") {
        result = (convertedUnit == "Kilometer per hour")
            ? value * 1.852
            : (convertedUnit == "Mile per hour")
                ? value * 1.151
                : (convertedUnit == "Meter per second")
                    ? value / 1.944
                    : value;
      } else {
        result = value;
      }
    }

    return result;
  }
}
