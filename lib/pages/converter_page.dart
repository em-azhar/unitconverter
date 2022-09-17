import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitconverter/data.dart';

class ConverterPage extends StatefulWidget {
  final String quantityName;

  const ConverterPage({
    Key? key,
    required this.quantityName,
  }) : super(key: key);

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  int _listIndex1 = 0;
  int _listIndex2 = 0;

  String _textFieldText = "";

  void _numkeyPressed() {
    setState(() {
      _textFieldText += "1";
    });
  }

  void _showSlider(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(
          context,
        ),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String quantityName = widget.quantityName;

    Data data = Data(quantityName: quantityName);

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/converterpage_backgrounds/${data.background()}.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 25, bottom: 60),
                child: Text(
                  data.quantityName,
                  style: TextStyle(
                    fontSize: 65,
                    color: data.quantityNameColor(),
                  ),
                ),
              ),
              Column(
                children: [
                  Center(
                    child: Text(
                      _textFieldText,
                      style: TextStyle(
                        fontSize: 70,
                        color: data.quantityNameColor(),
                      ),
                    ),
                  ),
                  Center(
                    child: CupertinoButton(
                      onPressed: () => _showSlider(
                        CupertinoPicker(
                          itemExtent: 45,
                          onSelectedItemChanged: (int selectedItem) {
                            setState(
                              () {
                                _listIndex1 = selectedItem;
                              },
                            );
                          },
                          children: List<Widget>.generate(
                            data.length(),
                            (int index) {
                              return Center(
                                child: Text(
                                  data.list()[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      child: Text(
                        data.list()[_listIndex1],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            "data",
                            style: TextStyle(
                              fontSize: 70,
                              color: data.quantityNameColor(),
                            ),
                          ),
                        ),
                        Center(
                          child: CupertinoButton(
                            onPressed: () => _showSlider(
                              CupertinoPicker(
                                itemExtent: 45,
                                onSelectedItemChanged: (int selectedItem) {
                                  setState(
                                    () {
                                      _listIndex2 = selectedItem;
                                    },
                                  );
                                },
                                children: List<Widget>.generate(
                                  data.length(),
                                  (int index) {
                                    return Center(
                                      child: Text(
                                        data.list()[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            child: Text(
                              data.list()[_listIndex2],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: CupertinoColors
                                .tertiarySystemGroupedBackground.darkColor,
                            border: Border.all(
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30, top: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumpadButton(
                                    number: 1,
                                    buttonClicked: _numkeyPressed,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {},
                                    number: 2,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {},
                                    number: 3,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumpadButton(
                                    buttonClicked: () {},
                                    number: 4,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {},
                                    number: 5,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {},
                                    number: 6,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumpadButton(
                                    buttonClicked: () {},
                                    number: 7,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {},
                                    number: 8,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {},
                                    number: 9,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 123,
                                    child: CupertinoButton(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const Text(
                                        ".",
                                        style: TextStyle(
                                          color: CupertinoColors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {},
                                    number: 0,
                                  ),
                                  SizedBox(
                                    width: 123,
                                    child: CupertinoButton(
                                      padding: const EdgeInsets.all(3.0),
                                      child: const Icon(
                                        CupertinoIcons.delete_left,
                                        color: CupertinoColors.white,
                                        size: 22,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          onPressed: buttonClicked,
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
