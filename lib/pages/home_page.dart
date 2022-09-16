import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitconverter/pages/converter_page.dart';
import 'package:unitconverter/widgets/quantity_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg.png",
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
                const Text(
                  "Unit Converter",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Convert units on the go.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
                              icon: const AssetImage("assets/icons/area.png"),
                              quantityName: "Area",
                              textColor: const Color.fromRGBO(124, 83, 254, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const ConverterPage(
                                      quantityName: "Area",
                                    ),
                                  ),
                                );
                              },
                            ),
                            QuantityButton(
                              icon: const AssetImage("assets/icons/time.png"),
                              quantityName: "Time",
                              textColor: const Color.fromRGBO(255, 63, 191, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const ConverterPage(
                                      quantityName: "Time",
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
                              icon: const AssetImage("assets/icons/volume.png"),
                              quantityName: "Volume",
                              textColor: const Color.fromRGBO(255, 136, 54, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const ConverterPage(
                                      quantityName: "Volume",
                                    ),
                                  ),
                                );
                              },
                            ),
                            QuantityButton(
                              icon: const AssetImage(
                                  "assets/icons/temperature.png"),
                              quantityName: "Temperature",
                              textColor: const Color.fromRGBO(77, 123, 255, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const ConverterPage(
                                      quantityName: "Temperature",
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
                              icon: const AssetImage("assets/icons/length.png"),
                              quantityName: "Length",
                              textColor: const Color.fromRGBO(51, 169, 191, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const ConverterPage(
                                      quantityName: "Length",
                                    ),
                                  ),
                                );
                              },
                            ),
                            QuantityButton(
                              icon: const AssetImage("assets/icons/speed.png"),
                              quantityName: "Speed",
                              textColor: const Color.fromRGBO(46, 222, 97, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const ConverterPage(
                                      quantityName: "Speed",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
