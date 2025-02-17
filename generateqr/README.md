# QR Generator App

A modern Flutter application for generating various types of QR codes including text, URLs, contact information, WiFi credentials, and more.

## Technical Overview

### Development Environment
- Flutter SDK: 3.x.x
- Dart: 3.x.x
- Minimum Android SDK: 21
- iOS Deployment Target: 11.0

### Architecture & Structure

```
lib/
├── screens/                     # UI screens
│   ├── generate_qr/            # QR generation screens
│   │   ├── business_qr.dart
│   │   ├── contact_qr.dart
│   │   ├── email_qr.dart
│   │   ├── event_qr.dart
│   │   ├── instagram_qr.dart
│   │   ├── telephone_qr.dart
│   │   ├── text_qr.dart
│   │   ├── twitter_qr.dart
│   │   ├── website_qr.dart
│   │   └── whatsapp_qr.dart
│   └── qr_display.dart         # QR code display screen
├── utils/                      # Utility functions
│   └── validators.dart         # Input validation functions
└── main.dart                   # App entry point

```

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  qr_flutter: ^4.1.0          # QR code generation
  share_plus: ^7.0.0          # Sharing functionality
  permission_handler: ^10.0.0  # Permission management
  path_provider: ^2.0.0       # File system access
```

### Key Features

1. **Multiple QR Types Support**
   - Text QR
   - Website URL QR
   - WiFi Credentials QR
   - Event Details QR
   - Contact Information QR (vCard format)
   - Business Card QR
   - Location QR
   - WhatsApp QR
   - Email QR
   - Social Media QRs (Twitter, Instagram)
   - Phone Number QR

2. **Input Validation**
   - Email format validation
   - Phone number format validation
   - URL format validation
   - Required field validation
   - Social media username validation

3. **QR Code Standards**
   - vCard format for contacts
   - WiFi configuration format
   - Calendar event format
   - URL schemes for various platforms

4. **UI/UX Features**
   - Dark theme implementation
   - Responsive layout
   - Platform-specific design elements
   - Input error handling
   - Loading states
   - Error states

### Implementation Details

#### QR Code Generation
```dart
QrImageView(
  data: qrData,
  version: QrVersions.auto,
  size: 200,
  backgroundColor: Colors.white,
)
```

#### Data Formats

1. **vCard Format**
```
BEGIN:VCARD
VERSION:3.0
N:lastName;firstName;;;
FN:firstName lastName
ORG:company
TEL:phoneNumber
EMAIL:emailAddress
ADR:;;street;city;;;country
END:VCARD
```

2. **WiFi Format**
```
WIFI:T:WPA;S:network_name;P:password;;
```

3. **Event Format**
```
BEGIN:VEVENT
SUMMARY:eventName
DTSTART:startDateTime
DTEND:endDateTime
LOCATION:location
DESCRIPTION:description
END:VEVENT
```

### Build and Run

1. **Clone the Repository**
```bash
git clone [repository-url]
cd qr-generator
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Run the App**
```bash
flutter run
```

### Platform-Specific Requirements

#### Android
- Add permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.SHARE"/>
```

#### iOS
- Add permissions to `ios/Runner/Info.plist`:
```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to photo library to save QR codes</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>This app needs access to photo library to save QR codes</string>
```


### Performance Considerations

1. **State Management**
   - Local state management using `setState`
   - Efficient widget rebuilds
   - Memory leak prevention

2. **Image Handling**
   - Proper asset management
   - Image caching
   - Responsive sizing

3. **Input Processing**
   - Debounced text input
   - Efficient validation
   - Error handling
