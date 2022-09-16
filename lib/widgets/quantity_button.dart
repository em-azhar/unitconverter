import 'package:flutter/cupertino.dart';

class QuantityButton extends StatelessWidget {
  final VoidCallback onPressed;
  final AssetImage icon;
  final String quantityName;
  final Color textColor;

  const QuantityButton({
    Key? key,
    required this.icon,
    required this.quantityName,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.9,
      onPressed: onPressed,
      child: Container(
        height: 150,
        width: 130,
        decoration: const BoxDecoration(
          color: Color.fromARGB(215, 26, 28, 59),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 25,
                bottom: 23,
              ),
              child: Image(
                height: 65,
                width: 65,
                image: icon,
              ),
            ),
            Text(
              quantityName,
              style: TextStyle(
                fontSize: 22,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
