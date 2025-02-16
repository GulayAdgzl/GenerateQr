import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventQrPage extends StatefulWidget {
  const EventQrPage({super.key});

  @override
  State<EventQrPage> createState() => _EventQrPageState();
}

class _EventQrPageState extends State<EventQrPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? qrData;

  @override
  void dispose() {
    _nameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFFB800),
              onPrimary: Colors.black,
              surface: Color(0xFF1E1E1E),
              onSurface: Color(0xFFD9D9D9),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFFFFB800),
                onPrimary: Colors.black,
                surface: Color(0xFF1E1E1E),
                onSurface: Color(0xFFD9D9D9),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final DateTime dateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        controller.text = dateTime.toString().substring(0, 16);
      }
    }
  }

  void generateQrCode() {
    final name = _nameController.text.trim();
    final startDate = _startDateController.text;
    final endDate = _endDateController.text;
    final location = _locationController.text.trim();
    final description = _descriptionController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter event name')),
      );
      return;
    }

    if (startDate.isEmpty || endDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both start and end dates')),
      );
      return;
    }

    // Format: BEGIN:VEVENT\nSUMMARY:name\nDTSTART:startDate\nDTEND:endDate\nLOCATION:location\nDESCRIPTION:description\nEND:VEVENT
    final eventData = '''BEGIN:VEVENT
SUMMARY:$name
DTSTART:${startDate.replaceAll(RegExp(r'[^0-9]'), '')}
DTEND:${endDate.replaceAll(RegExp(r'[^0-9]'), '')}
LOCATION:$location
DESCRIPTION:$description
END:VEVENT''';

    setState(() {
      qrData = eventData;
    });
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
          'Event',
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
              // Event Icon
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Image.asset(
                  'assets/images/event.png',
                  width: 64,
                  height: 64,
                  color: const Color(0xFFFFB800),
                ),
              ),

              // Event Name Input
              const Text(
                'Event Name',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(_nameController, 'Enter name'),
              const SizedBox(height: 16),

              // Start Date and Time
              const Text(
                'Start Date and Time',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                _startDateController,
                '12 Dec 2024, 10:00 am',
                onTap: () => _selectDateTime(_startDateController),
                readOnly: true,
              ),
              const SizedBox(height: 16),

              // End Date and Time
              const Text(
                'End Date and Time',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                _endDateController,
                '12 Dec 2024, 10:00 pm',
                onTap: () => _selectDateTime(_endDateController),
                readOnly: true,
              ),
              const SizedBox(height: 16),

              // Event Location
              const Text(
                'Event Location',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(_locationController, 'Enter location'),
              const SizedBox(height: 16),

              // Description
              const Text(
                'Description',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                _descriptionController,
                'Enter any details',
                maxLines: 4,
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
              if (qrData != null && qrData!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: QrImageView(
                    data: qrData!,
                    version: QrVersions.auto,
                    size: 200,
                    backgroundColor: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    int maxLines = 1,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Color(0xFFD9D9D9)),
      maxLines: maxLines,
      onTap: onTap,
      readOnly: readOnly,
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
