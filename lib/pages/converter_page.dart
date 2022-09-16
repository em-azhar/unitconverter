import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    final String quantityName = widget.quantityName;
    return Scaffold(
      body: SafeArea(
        child: Text(
          quantityName,
        ),
      ),
    );
  }
}
