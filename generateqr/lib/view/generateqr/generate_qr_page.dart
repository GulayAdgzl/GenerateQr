import 'package:flutter/material.dart';
import 'package:generateqr/view/businessqr/business_qr_page.dart';
import 'package:generateqr/view/contactqr/contact_qr_page.dart';
import 'package:generateqr/view/emailqr/email_qr_page.dart';
import 'package:generateqr/view/eventqr/event_qr_page.dart';
import 'package:generateqr/view/instagramqr/instagram_qr_page.dart';
import 'package:generateqr/view/textqr/text_qr_page.dart';
import 'package:generateqr/view/twitterqr/twitter_qr_page.dart';
import 'package:generateqr/view/websiteqr/website_qr.dart';
import 'package:generateqr/view/whatsappqr/whatsapp_qr_page.dart';
import 'package:generateqr/view/wifiqr/wifi_qr_page.dart';
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
          _buildQrOption(context, 'assets/images/text.png', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TextQrPage()),
            );
          }),
          _buildQrOption(context, 'assets/images/website.png', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WebsiteQrPage()),
            );
          }),
          _buildQrOption(context, 'assets/images/wifi.png', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WifiQrPage()),
            );
          }),
          _buildQrOption(context, 'assets/images/event.png', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EventQrPage()),
            );
          }),
          _buildQrOption(context, 'assets/images/contact.png', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactQrPage()),
            );
          }),
          _buildQrOption(context, 'assets/images/business.png', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BusinessQrPage()),
            );
          }),
          _buildQrOption(context, 'assets/images/whatsapp.png', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WhatsappQrPage()),
            );
          }),
          _buildQrOption(context, 'assets/images/email.png', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmailQrPage()),
            );
          }),
          _buildQrOption(context, 'assets/images/twitter.png', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TwitterQrPage()),
            );
          }),
          _buildQrOption(context, 'assets/images/instagram.png', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InstagramQrPage()),
            );
          }),
          _buildQrOption(context, 'assets/images/telephone.png', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TelephoneQrPage()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildQrOption(
      BuildContext context, String imagePath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
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
