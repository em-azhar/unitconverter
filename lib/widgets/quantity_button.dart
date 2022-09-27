import 'package:flutter/cupertino.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton({
    Key? key,
    required this.icon,
    required this.quantityName,
    required this.textColor,
    required this.onPressed,
    required this.bgColor,
  }) : super(key: key);

  final VoidCallback onPressed;
  final AssetImage icon;
  final String quantityName;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.9,
      onPressed: onPressed,
      child: Container(
        height: 150,
        width: 130,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(
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
