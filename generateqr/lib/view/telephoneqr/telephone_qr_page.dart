import 'package:flutter/material.dart';
import 'package:generateqr/view/showqr/qr_display_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TelephoneQrPage extends StatefulWidget {
  const TelephoneQrPage({super.key});

  @override
  State<TelephoneQrPage> createState() => _TelephoneQrPageState();
}

class _TelephoneQrPageState extends State<TelephoneQrPage> {
  final TextEditingController _phoneController = TextEditingController();
  String? qrData;
  String? errorText;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  bool isValidPhoneNumber(String phone) {
    // Remove any spaces, dashes, or parentheses
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    // Check if it starts with + and has 10-15 digits
    return RegExp(r'^\+?\d{10,15}$').hasMatch(cleanPhone);
  }

  void generateQrCode() {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      setState(() {
        errorText = 'Please enter phone number';
        qrData = null;
      });
      return;
    }

    if (!isValidPhoneNumber(phone)) {
      setState(() {
        errorText = 'Please enter a valid phone number';
        qrData = null;
      });
      return;
    }

    // Format phone number: remove any non-digit except + and ensure it starts with +
    String formattedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    if (!formattedPhone.startsWith('+')) {
      formattedPhone = '+' + formattedPhone;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRDisplayPage(data: 'tel:$formattedPhone'),
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
          'Phone',
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
              // Phone Icon
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Image.asset(
                  'assets/images/text.png',
                  width: 86,
                  height: 82,
                ),
              ),

              // Phone Number Input
              const Text(
                'Phone Number',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                style: const TextStyle(color: Color(0xFFD9D9D9)),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
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
