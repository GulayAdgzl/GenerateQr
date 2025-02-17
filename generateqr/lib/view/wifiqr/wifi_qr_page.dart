import 'package:flutter/material.dart';
import 'package:generateqr/view/showqr/qr_display_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WifiQrPage extends StatefulWidget {
  const WifiQrPage({super.key});

  @override
  State<WifiQrPage> createState() => _WifiQrPageState();
}

class _WifiQrPageState extends State<WifiQrPage> {
  final TextEditingController _networkController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? qrData;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _networkController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void generateQrCode() {
    final network = _networkController.text.trim();
    final password = _passwordController.text.trim();

    if (network.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter network name')),
      );
      return;
    }

    MaterialPageRoute(
      builder: (context) =>
          QRDisplayPage(data: 'WIFI:T:WPA;S:$network;P:$password;;'),
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
          'Wi-Fi',
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
              // WiFi Icon
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/images/wifi.png',
                  width: 64,
                  height: 64,
                ),
              ),

              // Network Name Input
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Network',
                  style: TextStyle(
                    color: Color(0xFFD9D9D9),
                    fontSize: 16,
                  ),
                ),
              ),
              TextField(
                controller: _networkController,
                style: const TextStyle(color: Color(0xFFD9D9D9)),
                decoration: InputDecoration(
                  hintText: 'Enter network name',
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

              const SizedBox(height: 16),

              // Password Input
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Password',
                  style: TextStyle(
                    color: Color(0xFFD9D9D9),
                    fontSize: 16,
                  ),
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(color: Color(0xFFD9D9D9)),
                decoration: InputDecoration(
                  hintText: 'Enter password',
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
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color(0xFFD9D9D9),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              // Generate Button
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: ElevatedButton(
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
              ),

              // QR Code Display
            ],
          ),
        ),
      ),
    );
  }
}
