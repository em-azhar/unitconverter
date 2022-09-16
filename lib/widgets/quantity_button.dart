import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.9,
      onPressed: () {},
      child: Container(
        height: 150,
        width: 130,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(40, 42, 92, 0.8),
        ),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(
                top: 25,
                bottom: 20,
              ),
              child: Image(
                height: 60,
                width: 60,
                image: AssetImage(
                  "assets/icons/area.png",
                ),
              ),
            ),
            Text(
              "Area",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
