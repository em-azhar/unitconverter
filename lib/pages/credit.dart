import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Credit extends StatelessWidget {
  Credit({Key? key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 35, 1),
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 16, right: 10),
            child: Text("ver 0.1"),
          ),
        ],
        leading: CupertinoButton(
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
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
              children: const [
                Text(
                  "Hello, World! 👋",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    "Programmed & Created by",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                Text(
                  "Azhar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  "   Consider Following!   😊",
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      child: const Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _openLinks(_instagram);
                      },
                    ),
                    CupertinoButton(
                      child: const Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _openLinks(_facebook);
                      },
                    ),
                    CupertinoButton(
                      child: const Icon(
                        FontAwesomeIcons.github,
                        color: Colors.white,
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
