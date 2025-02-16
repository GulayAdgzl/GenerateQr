import 'package:flutter/material.dart';
import 'package:generateqr/view/showqr/qr_display_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BusinessQrPage extends StatefulWidget {
  const BusinessQrPage({super.key});

  @override
  State<BusinessQrPage> createState() => _BusinessQrPageState();
}

class _BusinessQrPageState extends State<BusinessQrPage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  String? qrData;

  @override
  void dispose() {
    _companyNameController.dispose();
    _industryController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s-]{8,}$').hasMatch(phone);
  }

  void generateQrCode() {
    final companyName = _companyNameController.text.trim();

    if (companyName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter company name')),
      );
      return;
    }

    final email = _emailController.text.trim();
    if (email.isNotEmpty && !isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    final phone = _phoneController.text.trim();
    if (phone.isNotEmpty && !isValidPhone(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    // Format business card data
    final businessData = '''BEGIN:VCARD
VERSION:3.0
ORG:$companyName
${_industryController.text.isNotEmpty ? 'NOTE:Industry: ${_industryController.text}\n' : ''}${phone.isNotEmpty ? 'TEL:$phone\n' : ''}${email.isNotEmpty ? 'EMAIL:$email\n' : ''}${_websiteController.text.isNotEmpty ? 'URL:${_websiteController.text}\n' : ''}${_addressController.text.isNotEmpty ? 'ADR:;;${_addressController.text};${_cityController.text};;;${_countryController.text}\n' : ''}END:VCARD''';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRDisplayPage(data: businessData),
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
          'Business',
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
              // Business Icon
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Image.asset(
                  'assets/images/business.png',
                  width: 86,
                  height: 82,
                  color: const Color(0xFFFFB800),
                ),
              ),

              // Company Name
              const Text(
                'Company Name',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(_companyNameController, 'Enter name'),
              const SizedBox(height: 16),

              // Industry
              const Text(
                'Industry',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(_industryController, 'e.g Food/Agency'),
              const SizedBox(height: 16),

              // Phone and Email Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Phone',
                          style: TextStyle(
                            color: Color(0xFFD9D9D9),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildTextField(_phoneController, 'Enter phone'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                            color: Color(0xFFD9D9D9),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildTextField(_emailController, 'Enter email'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Website
              const Text(
                'Website',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(_websiteController, 'Enter website'),
              const SizedBox(height: 16),

              // Address
              const Text(
                'Address',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(_addressController, 'Enter address'),
              const SizedBox(height: 16),

              // City and Country Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'City',
                          style: TextStyle(
                            color: Color(0xFFD9D9D9),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildTextField(_cityController, 'Enter city'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Country',
                          style: TextStyle(
                            color: Color(0xFFD9D9D9),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildTextField(_countryController, 'Enter country'),
                      ],
                    ),
                  ),
                ],
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

  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
  ) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Color(0xFFD9D9D9)),
      decoration: InputDecoration(
        hintText: hintText,
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
    );
  }
}
