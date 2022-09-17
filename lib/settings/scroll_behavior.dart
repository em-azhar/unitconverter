import 'package:flutter/cupertino.dart';

class ScrollGlow extends ScrollBehavior {
  Widget buildOverScrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
