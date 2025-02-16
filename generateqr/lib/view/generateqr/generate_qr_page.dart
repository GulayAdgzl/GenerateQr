import 'package:flutter/material.dart';
import 'package:generateqr/widgets/generate_keys.dart';

class GenerateQrPage extends StatelessWidget {
  const GenerateQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        GenerateKeys().titleGenerate,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Color(0xFFD9D9D9),
            ),
      )),
    );
  }
}
