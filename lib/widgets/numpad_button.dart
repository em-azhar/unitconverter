import 'package:flutter/cupertino.dart';

class NumpadButton extends StatelessWidget {
  final dynamic number;
  final VoidCallback buttonClicked;
  final bool dark;

  const NumpadButton({
    Key? key,
    required this.number,
    required this.buttonClicked,
    required this.dark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 118,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: CupertinoButton(
          padding: const EdgeInsets.all(0),
          color: dark
              ? CupertinoColors.systemGrey.highContrastColor
              : CupertinoColors.white,
          onPressed: buttonClicked,
          child: Text(
            number.toString(),
            style: TextStyle(
              color: dark ? CupertinoColors.white : CupertinoColors.black,
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
