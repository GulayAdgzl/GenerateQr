import 'package:flutter/material.dart';
import 'package:generateqr/view/showqr/qr_display_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EmailQrPage extends StatefulWidget {
  const EmailQrPage({super.key});

  @override
  State<EmailQrPage> createState() => _EmailQrPageState();
}

class _EmailQrPageState extends State<EmailQrPage> {
  final TextEditingController _emailController = TextEditingController();
  String? qrData;
  String? errorText;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void generateQrCode() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        errorText = 'Please enter email address';
      });
      return;
    }

    if (!isValidEmail(email)) {
      setState(() {
        errorText = 'Please enter a valid email address';
      });
      return;
    }

    setState(() {
      errorText = null;
    });

    // Email format for QR code
    final emailData = 'mailto:$email';

    // Navigate to QR Display Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRDisplayPage(data: emailData),
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
          'Email',
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
              // Email Icon
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Image.asset(
                  'assets/images/email.png',
                  width: 86,
                  height: 82,
                  color: const Color(0xFFFFB800),
                ),
              ),

              // Email Input
              const Text(
                'Email',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Color(0xFFD9D9D9)),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter email address',
                  hintStyle: TextStyle(
                    color: const Color(0xFFD9D9D9).withOpacity(0.5),
                  ),
                  errorText: errorText,
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
