import 'package:flutter/material.dart';
import 'package:generateqr/view/showqr/qr_display_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InstagramQrPage extends StatefulWidget {
  const InstagramQrPage({super.key});

  @override
  State<InstagramQrPage> createState() => _InstagramQrPageState();
}

class _InstagramQrPageState extends State<InstagramQrPage> {
  final TextEditingController _usernameController = TextEditingController();
  String? qrData;
  String? errorText;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  bool isValidUsername(String username) {
    // Instagram username rules: 1-30 characters, letters, numbers, periods, and underscores
    // Periods and underscores can't be at the start or end and can't appear consecutively
    return RegExp(r'^[a-zA-Z0-9][a-zA-Z0-9._]*[a-zA-Z0-9]$')
            .hasMatch(username) &&
        !username.contains('..') &&
        !username.contains('__') &&
        !username.contains('._') &&
        !username.contains('_.') &&
        username.length >= 1 &&
        username.length <= 30;
  }

  void generateQrCode() {
    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      setState(() {
        errorText = 'Please enter Instagram username';
        qrData = null;
      });
      return;
    }

    // Remove @ if user included it
    final cleanUsername =
        username.startsWith('@') ? username.substring(1) : username;

    if (!isValidUsername(cleanUsername)) {
      setState(() {
        errorText = 'Please enter a valid Instagram username';
        qrData = null;
      });
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            QRDisplayPage(data: 'https://instagram.com/$cleanUsername'),
      ),
    );
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
          'Instagram',
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
              // Instagram Icon
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Image.asset(
                  'assets/images/instagram.png',
                  width: 86,
                  height: 82,
                  color: const Color(0xFFFFB800),
                ),
              ),

              // Username Input
              const Text(
                'Username',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _usernameController,
                style: const TextStyle(color: Color(0xFFD9D9D9)),
                decoration: InputDecoration(
                  hintText: 'Enter Instagram username',
                  hintStyle: TextStyle(
                    color: const Color(0xFFD9D9D9).withOpacity(0.5),
                  ),
                  errorText: errorText,
                  prefixText: '@',
                  prefixStyle: const TextStyle(
                    color: Color(0xFFD9D9D9),
                    fontSize: 16,
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
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Generate Button
              ElevatedButton(
                onPressed: generateQrCode,
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
            ],
          ),
        ),
      ),
    );
  }
}
