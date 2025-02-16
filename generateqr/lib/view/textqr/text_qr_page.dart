import 'package:flutter/material.dart';
import 'package:generateqr/view/showqr/qr_display_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TextQrPage extends StatefulWidget {
  const TextQrPage({super.key});

  @override
  State<TextQrPage> createState() => _TextQrPageState();
}

class _TextQrPageState extends State<TextQrPage> {
  final TextEditingController _textController = TextEditingController();
  String? qrData;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFD9D9D9),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Text',
          style: TextStyle(
            color: Color(0xFFD9D9D9),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // QR Icon
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Image.asset(
                  'assets/images/text.png',
                  width: 86,
                  height: 82,
                  color: const Color(0xFFFFB800),
                ),
              ),

              // Text Label
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Text',
                  style: TextStyle(
                    color: Color(0xFFD9D9D9),
                    fontSize: 16,
                  ),
                ),
              ),

              // Text Input Field
              TextField(
                controller: _textController,
                style: const TextStyle(color: Color(0xFFD9D9D9)),
                decoration: InputDecoration(
                  hintText: 'Enter text',
                  hintStyle: TextStyle(
                    color: const Color(0xFFD9D9D9).withOpacity(0.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFFB800),
                      width: 1,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFFB800),
                      width: 2,
                    ),
                  ),
                ),
              ),

              // Generate Button
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QRDisplayPage(data: _textController.text),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB800),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Generate QR Code',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // QR Code Display
            ],
          ),
        ),
      ),
    );
  }
}
