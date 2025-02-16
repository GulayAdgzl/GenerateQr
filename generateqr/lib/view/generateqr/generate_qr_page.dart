import 'package:flutter/material.dart';

class GenerateQrPage extends StatelessWidget {
  const GenerateQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Generate Qr",
        style: TextStyle(
          color: Color(0xFFD9D9D9),
          fontSize: 27,
        ),
      )),
    );
  }
}
