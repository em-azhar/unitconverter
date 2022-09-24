import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitconverter/calculations/conversion.dart';
import 'package:unitconverter/model/data.dart';

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
  late FixedExtentScrollController scrollController1;
  late FixedExtentScrollController scrollController2;

  int _listIndex1 = 0;
  int _listIndex2 = 1;

  @override
  void initState() {
    super.initState();
    scrollController1 = FixedExtentScrollController(initialItem: _listIndex1);
    scrollController2 = FixedExtentScrollController(initialItem: _listIndex2);
  }

  String _textFieldText = "";
  String _resultFieldText = "";

  String _result = "";
  void _numkeyPressed(String digit, String toBeConvertedUnit,
      String convertedUnit, String quantityName) {
    setState(() {
      if (_textFieldText.length < 10) {
        _textFieldText += digit;
      }
      if (_textFieldText.isNotEmpty && _textFieldText != "-") {
        _resultFieldText =
            _convert(toBeConvertedUnit, convertedUnit, quantityName);
      }
    });
  }

  void _backspacePressed(
      String toBeConvertedUnit, String convertedUnit, String quantityName) {
    setState(() {
      if (_textFieldText.isNotEmpty) {
        _textFieldText = _textFieldText.substring(0, _textFieldText.length - 1);
      }
      if (_textFieldText.substring(0) == "0") {
        _textFieldText = "";
      }

      if (_textFieldText != "-") {
        _resultFieldText = (_textFieldText.isNotEmpty)
            ? _convert(toBeConvertedUnit, convertedUnit, quantityName)
            : "";
      } else if (_textFieldText == "-") {
        _resultFieldText = "";
      }
    });
  }

  final Conversion _conversion = Conversion();

  String _convert(
      String toBeConvertedUnit, String convertedUnit, String quantityName) {
    setState(() {
      _result = _conversion
          .conversionResult(num.parse(_textFieldText), toBeConvertedUnit,
              convertedUnit, quantityName)
          .toString();
    });
    return _result;
  }

  void _showSlider(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          Container(
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
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: (() {
            Navigator.pop(context);
          }),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController1.dispose();
    scrollController2.dispose();
    super.dispose();
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
                  padding: const EdgeInsets.only(left: 8),
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 14, top: 15, bottom: 60),
                child: Text(
                  data.quantityName,
                  style: const TextStyle(
                    fontSize: 65,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        _textFieldText,
                        style: TextStyle(
                          fontSize: (_textFieldText.length < 11) ? 60 : 55,
                          color: data.quantityNameColor(),
                        ),
                      ),
                    ),
                    Center(
                      child: CupertinoButton(
                        onPressed: () {
                          scrollController1.dispose();
                          scrollController1 = FixedExtentScrollController(
                            initialItem: _listIndex1,
                          );
                          _showSlider(
                            CupertinoPicker(
                              looping: false,
                              itemExtent: 45,
                              scrollController: scrollController1,
                              onSelectedItemChanged: (int selectedItem) {
                                setState(() {
                                  _numkeyPressed(
                                    "",
                                    data.list()[selectedItem],
                                    data.list()[_listIndex2],
                                    data.quantityName,
                                  );
                                  _listIndex1 = selectedItem;
                                });
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
                          );
                        },
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
              ),
              Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  const Divider(
                    thickness: 2,
                    height: 80,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        height: 53,
                        width: 53,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadiusDirectional.all(
                            Radius.circular(53),
                          ),
                          color: Color.fromRGBO(18, 18, 35, 1),
                        ),
                      ),
                      CupertinoButton(
                        child: Icon(
                          CupertinoIcons.arrow_up_arrow_down_circle_fill,
                          size: 50,
                          color: data.quantityNameColor(),
                        ),
                        onPressed: () {
                          setState(() {
                            int temp = _listIndex1;
                            _listIndex1 = _listIndex2;
                            _listIndex2 = temp;
                            _numkeyPressed(
                              "",
                              data.list()[_listIndex1],
                              data.list()[_listIndex2],
                              data.quantityName,
                            );
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              _resultFieldText,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 60,
                                color: data.quantityNameColor(),
                              ),
                            ),
                          ),
                          Center(
                            child: CupertinoButton(
                              onPressed: () {
                                scrollController2.dispose();
                                scrollController2 = FixedExtentScrollController(
                                    initialItem: _listIndex2);
                                _showSlider(
                                  CupertinoPicker(
                                    scrollController: scrollController2,
                                    looping: false,
                                    itemExtent: 45,
                                    onSelectedItemChanged: (int selectedItem) {
                                      setState(() {
                                        _numkeyPressed(
                                          "",
                                          data.list()[_listIndex1],
                                          data.list()[selectedItem],
                                          data.quantityName,
                                        );
                                        _listIndex2 = selectedItem;
                                      });
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
                                );
                              },
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
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 230,
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
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumpadButton(
                                    number: 1,
                                    buttonClicked: () {
                                      _numkeyPressed(
                                        "1",
                                        data.list()[_listIndex1],
                                        data.list()[_listIndex2],
                                        data.quantityName,
                                      );
                                    },
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed(
                                        "2",
                                        data.list()[_listIndex1],
                                        data.list()[_listIndex2],
                                        data.quantityName,
                                      );
                                    },
                                    number: 2,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed(
                                        "3",
                                        data.list()[_listIndex1],
                                        data.list()[_listIndex2],
                                        data.quantityName,
                                      );
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
                                      _numkeyPressed(
                                        "4",
                                        data.list()[_listIndex1],
                                        data.list()[_listIndex2],
                                        data.quantityName,
                                      );
                                    },
                                    number: 4,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed(
                                        "5",
                                        data.list()[_listIndex1],
                                        data.list()[_listIndex2],
                                        data.quantityName,
                                      );
                                    },
                                    number: 5,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed(
                                        "6",
                                        data.list()[_listIndex1],
                                        data.list()[_listIndex2],
                                        data.quantityName,
                                      );
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
                                      _numkeyPressed(
                                        '7',
                                        data.list()[_listIndex1],
                                        data.list()[_listIndex2],
                                        data.quantityName,
                                      );
                                    },
                                    number: 7,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed(
                                        "8",
                                        data.list()[_listIndex1],
                                        data.list()[_listIndex2],
                                        data.quantityName,
                                      );
                                    },
                                    number: 8,
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      _numkeyPressed(
                                        "9",
                                        data.list()[_listIndex1],
                                        data.list()[_listIndex2],
                                        data.quantityName,
                                      );
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
                                    child: GestureDetector(
                                      onLongPress: () {
                                        if (_textFieldText.isEmpty &&
                                            quantityName == "Temperature") {
                                          _numkeyPressed(
                                            "-",
                                            data.list()[_listIndex1],
                                            data.list()[_listIndex2],
                                            data.quantityName,
                                          );
                                        }
                                      },
                                      child: CupertinoButton(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          (quantityName == "Temperature")
                                              ? "./-"
                                              : ".",
                                          style: const TextStyle(
                                            color: CupertinoColors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22,
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_textFieldText.isEmpty) {
                                            _numkeyPressed(
                                              "0.",
                                              data.list()[_listIndex1],
                                              data.list()[_listIndex2],
                                              data.quantityName,
                                            );
                                          }
                                          if (!_textFieldText.contains('.')) {
                                            _numkeyPressed(
                                              ".",
                                              data.list()[_listIndex1],
                                              data.list()[_listIndex2],
                                              data.quantityName,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  NumpadButton(
                                    buttonClicked: () {
                                      if (_textFieldText.isNotEmpty) {
                                        _numkeyPressed(
                                          "0",
                                          data.list()[_listIndex1],
                                          data.list()[_listIndex2],
                                          data.quantityName,
                                        );
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
                                        _backspacePressed(
                                          data.list()[_listIndex1],
                                          data.list()[_listIndex2],
                                          data.quantityName,
                                        );
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
