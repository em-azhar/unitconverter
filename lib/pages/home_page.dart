import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitconverter/pages/converter_page.dart';
import 'package:unitconverter/pages/credit.dart';
import 'package:unitconverter/widgets/quantity_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _dark = true;
  @override
  Widget build(BuildContext context) {
    Color bgColor = _dark
        ? const Color.fromARGB(215, 26, 28, 59)
        : const Color.fromARGB(53, 158, 158, 158);

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              (_dark)
                  ? "assets/images/bg_dark.png"
                  : "assets/images/bg_light.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Text(
                          "Unit Converter",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Convert units on the go.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CupertinoButton(
                        child: const Icon(
                          CupertinoIcons.info,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Credit(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 70, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QuantityButton(
                              bgColor: bgColor,
                              icon: const AssetImage("assets/icons/area.png"),
                              quantityName: "Area",
                              textColor: const Color.fromRGBO(124, 83, 254, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ConverterPage(
                                      quantityName: "Area",
                                      dark: _dark,
                                    ),
                                  ),
                                );
                              },
                            ),
                            QuantityButton(
                              bgColor: bgColor,
                              icon: const AssetImage("assets/icons/time.png"),
                              quantityName: "Time",
                              textColor: const Color.fromRGBO(255, 63, 191, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ConverterPage(
                                      quantityName: "Time",
                                      dark: _dark,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QuantityButton(
                              bgColor: bgColor,
                              icon: const AssetImage("assets/icons/volume.png"),
                              quantityName: "Volume",
                              textColor: const Color.fromRGBO(255, 136, 54, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ConverterPage(
                                      quantityName: "Volume",
                                      dark: _dark,
                                    ),
                                  ),
                                );
                              },
                            ),
                            QuantityButton(
                              bgColor: bgColor,
                              icon: const AssetImage(
                                  "assets/icons/temperature.png"),
                              quantityName: "Temperature",
                              textColor: const Color.fromRGBO(77, 123, 255, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ConverterPage(
                                      quantityName: "Temperature",
                                      dark: _dark,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QuantityButton(
                              bgColor: bgColor,
                              icon: const AssetImage("assets/icons/length.png"),
                              quantityName: "Length",
                              textColor: const Color.fromRGBO(51, 169, 191, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ConverterPage(
                                      quantityName: "Length",
                                      dark: _dark,
                                    ),
                                  ),
                                );
                              },
                            ),
                            QuantityButton(
                              bgColor: bgColor,
                              icon: const AssetImage("assets/icons/speed.png"),
                              quantityName: "Speed",
                              textColor: const Color.fromRGBO(46, 222, 97, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ConverterPage(
                                      quantityName: "Speed",
                                      dark: _dark,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 35),
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: CupertinoSwitch(
                      value: _dark,
                      onChanged: (value) {
                        setState(() {
                          _dark = value;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
