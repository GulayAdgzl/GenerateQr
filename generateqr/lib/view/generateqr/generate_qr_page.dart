import 'package:flutter/material.dart';
import 'package:generateqr/widgets/generate_keys.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFD9D9D9)),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: [
          _buildQrOption(context, Icons.person),
          _buildQrOption(context, Icons.language),
          _buildQrOption(context, Icons.wifi),
          _buildQrOption(context, Icons.event),
          _buildQrOption(context, Icons.person),
          _buildQrOption(context, Icons.business),
          _buildQrOption(context, Icons.location_on),
          _buildQrOption(context, Icons.whatsapp),
          _buildQrOption(context, Icons.email),
          _buildQrOption(context, FontAwesomeIcons.twitter),
          _buildQrOption(context, FontAwesomeIcons.instagram),
          _buildQrOption(context, Icons.send),
        ],
      ),
    );
  }

  Widget _buildQrOption(BuildContext context, IconData icon) {
    return InkWell(
      onTap: () {
        // Handle QR option tap
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFFF9500),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFD9D9D9),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
