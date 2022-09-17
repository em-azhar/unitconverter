import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitconverter/data.dart';

import '../widgets/numpad_button.dart';

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
  String _resultFieldText = "";

  void _numkeyPressed(String digit) {
    setState(() {
      if (_textFieldText.length < 10) {
        _textFieldText += digit;
      }
      _resultFieldText = (num.parse(_textFieldText) * 2).toString();
    });
  }

  void _backspacePressed() {
    setState(() {
      if (_textFieldText.isNotEmpty) {
        _textFieldText = _textFieldText.substring(0, _textFieldText.length - 1);
      }
      if (_textFieldText.substring(0) == "0") {
        _textFieldText = "";
      }

      _resultFieldText = (_textFieldText.isNotEmpty)
          ? (num.parse(_textFieldText) * 2).toString()
          : "";
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
      resizeToAvoidBottomInset: false,
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
                        fontSize: (_textFieldText.length < 11) ? 70 : 55,
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
                            _resultFieldText,
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
                                    buttonClicked: () {
                                      _numkeyPressed("1");
                                    },
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed("2");
                                    },
                                    number: 2,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed("3");
                                    },
                                    number: 3,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed("4");
                                    },
                                    number: 4,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed("5");
                                    },
                                    number: 5,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed("6");
                                    },
                                    number: 6,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed('7');
                                    },
                                    number: 7,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed("8");
                                    },
                                    number: 8,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed("9");
                                    },
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
                                      onPressed: () {
                                        if (!_textFieldText.contains('.') &&
                                            _textFieldText.isEmpty) {
                                          _numkeyPressed("0.");
                                        }
                                        if (!_textFieldText.contains('.')) {
                                          _numkeyPressed(".");
                                        }
                                      },
                                    ),
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      if (_textFieldText.isNotEmpty) {
                                        _numkeyPressed("0");
                                      }
                                    },
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
                                      onPressed: () {
                                        _backspacePressed();
                                      },
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
