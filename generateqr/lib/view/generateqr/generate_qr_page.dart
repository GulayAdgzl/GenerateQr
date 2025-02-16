import 'package:flutter/material.dart';
import 'package:generateqr/widgets/generate_keys.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';

class GenerateQrPage extends StatelessWidget {
  const GenerateQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text(
          'Generate QR',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: const Color(0xFFD9D9D9),
              ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: [
          _buildQrOption(context, 'assets/images/text.png'),
          _buildQrOption(context, 'assets/images/website.png'),
          _buildQrOption(context, 'assets/images/wifi.png'),
          _buildQrOption(context, 'assets/images/event.png'),
          _buildQrOption(context, 'assets/images/contact.png'),
          _buildQrOption(context, 'assets/images/business.png'),
          _buildQrOption(context, 'assets/images/location.png'),
          _buildQrOption(context, 'assets/images/whatsapp.png'),
          _buildQrOption(context, 'assets/images/email.png'),
          _buildQrOption(context, 'assets/images/twitter.png'),
          _buildQrOption(context, 'assets/images/instagram.png'),
          _buildQrOption(context, 'assets/images/telephone.png'),
        ],
      ),
    );
  }

  Widget _buildQrOption(BuildContext context, String imagePath) {
    return InkWell(
      onTap: () {
        // Handle QR option tap
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                imagePath,
                width: 86,
                height: 82,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
