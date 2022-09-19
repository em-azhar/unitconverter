import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class NumpadButton extends StatelessWidget {
  final dynamic number;
  final VoidCallback buttonClicked;

  const NumpadButton({
    Key? key,
    required this.number,
    required this.buttonClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 118,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: CupertinoButton(
          padding: const EdgeInsets.all(0),
          color: CupertinoColors.systemGrey.highContrastColor,
          onPressed: () async {
            Soundpool pool = Soundpool(streamType: StreamType.notification);
            int soundId = await rootBundle
                .load("audio/keyPress.wav")
                .then((ByteData soundData) {
              return pool.load(soundData);
            });
            int streamId = await pool.play(soundId);
            buttonClicked();
          },
          child: Text(
            number.toString(),
            style: const TextStyle(
              color: CupertinoColors.white,
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
