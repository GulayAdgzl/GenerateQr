import 'package:flutter/material.dart';
import 'package:generateqr/view/showqr/qr_display_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TwitterQrPage extends StatefulWidget {
  const TwitterQrPage({super.key});

  @override
  State<TwitterQrPage> createState() => _TwitterQrPageState();
}

class _TwitterQrPageState extends State<TwitterQrPage> {
  final TextEditingController _usernameController = TextEditingController();
  String? qrData;
  String? errorText;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  bool isValidUsername(String username) {
    // Twitter username rules: 4-15 characters, alphanumeric and underscores only
    return RegExp(r'^[A-Za-z0-9_]{4,15}$').hasMatch(username);
  }

  void generateQrCode() {
    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      setState(() {
        errorText = 'Please enter Twitter username';
        qrData = null;
      });
      return;
    }

    // Remove @ if user included it
    final cleanUsername =
        username.startsWith('@') ? username.substring(1) : username;

    if (!isValidUsername(cleanUsername)) {
      setState(() {
        errorText =
            'Please enter a valid Twitter username (4-15 characters, letters, numbers, and underscore only)';
        qrData = null;
      });
      return;
    }

    MaterialPageRoute(
      builder: (context) =>
          QRDisplayPage(data: 'https://twitter.com/$cleanUsername'),
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
          'Twitter',
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
              // Twitter Icon
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/images/twitter.png',
                  width: 86,
                  height: 82,
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
                  hintText: 'Enter twitter username',
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

              // QR Code Display
            ],
          ),
        ),
      ),
    );
  }
}
