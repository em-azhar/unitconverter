import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Credit extends StatelessWidget {
  Credit({
    Key? key,
    required this.dark,
  }) : super(key: key);

  final bool dark;

  final Uri _instagram = Uri.parse("https://instagram.com/thisizazhar/");
  final Uri _facebook = Uri.parse("https://facebook.com/thisizazhar/");
  final Uri _github = Uri.parse("https://github.com/em-azhar/");

  Future<void> _openLinks(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw "not found";
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = dark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor:
          dark ? const Color.fromRGBO(18, 18, 35, 1) : Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 10),
            child: Text(
              "ver 0.1",
              style: TextStyle(color: textColor),
            ),
          ),
        ],
        leading: CupertinoButton(
          child: Icon(
            CupertinoIcons.back,
            color: textColor,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Hello, World! 👋",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    "Programmed & Created by",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                Text(
                  "Azhar",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "   Consider Following!   😊",
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      child: Icon(
                        FontAwesomeIcons.instagram,
                        color: textColor,
                      ),
                      onPressed: () {
                        _openLinks(_instagram);
                      },
                    ),
                    CupertinoButton(
                      child: Icon(
                        FontAwesomeIcons.facebook,
                        color: textColor,
                      ),
                      onPressed: () {
                        _openLinks(_facebook);
                      },
                    ),
                    CupertinoButton(
                      child: Icon(
                        FontAwesomeIcons.github,
                        color: textColor,
                      ),
                      onPressed: () {
                        _openLinks(_github);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
