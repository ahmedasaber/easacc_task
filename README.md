# EasAcc Task - Flutter Mobile Application

A cross-platform mobile application built with Flutter for iOS and Android that features social media authentication, customizable settings, and an embedded web browser.

## 📱 Screen Shots

<p align="center">
  <img src="https://raw.githubusercontent.com/ahmedasaber/easacc_task/refs/heads/master/assets/project-images/1.jpg" width="19%" />
  <img src="https://raw.githubusercontent.com/ahmedasaber/easacc_task/refs/heads/master/assets/project-images/2.jpg" width="19%" />
  <img src="https://raw.githubusercontent.com/ahmedasaber/easacc_task/refs/heads/master/assets/project-images/3.jpg" width="19%" />
  <img src="https://raw.githubusercontent.com/ahmedasaber/easacc_task/refs/heads/master/assets/project-images/4.jpg" width="19%" />
  <img src="https://raw.githubusercontent.com/ahmedasaber/easacc_task/refs/heads/master/assets/project-images/5.jpg" width="19%" />
</p>

## 📱 Features

### 1. Social Media Login
- **Google Sign-In** - Authenticate using Google account
- **Facebook Sign-In** - Authenticate using Facebook account
- Seamless Firebase Authentication integration

### 2. Settings Page
- **URL Input** - Enter and save a custom web URL to display in the WebView
- **Edit Mode** - Toggle between read-only and edit modes for the URL field
- **Bluetooth Device Scanner** - Scan for nearby Bluetooth devices
    - Displays device ID and RSSI signal strength
    - Real-time scanning with loading indicators

### 3. WebView Page
- Displays the URL configured in the Settings page
- Full JavaScript support enabled
- Navigation controls and error handling

## 🏗️ Architecture

The project follows **Clean Architecture** principles with the following structure:

```
lib/
├── core/
│   ├── helper_fun/
│   │   ├── error_snack_bar.dart
│   │   └── on_generate.dart
│   └── services/
│       ├── bloc_observer_service.dart
│       ├── firebase_auth_service.dart
│       └── get_it_service.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repo/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   └── repo/
│   │   └── presentation/
│   │       ├── signin_cubit/
│   │       └── views/
│   └── settings/
│       └── presentation/
│           ├── cubit/
│           └── views/
├── firebase_options.dart
└── main.dart
```

## 🛠️ Technologies & Packages

| Package                 | Purpose                              |
|-------------------------|--------------------------------------|
| `flutter_bloc`          | State management using Cubit pattern |
| `firebase_core`         | Firebase initialization              |
| `firebase_auth`         | Firebase Authentication              |
| `google_sign_in`        | Google OAuth authentication          |
| `flutter_facebook_auth` | Facebook OAuth authentication        |
| `flutter_blue_plus`     | Bluetooth device scanning            |
| `webview_flutter`       | Embedded web browser                 |
| `get_it`                | Dependency injection                 |
| `dartz`                 | Functional programming (Either type) |
| `logger`                | Debug logging                        |
| `flutter_svg`           | SVG image rendering                  |
| `drop_down_list`        | Dropdown UI component                |

## 📋 Prerequisites

- Flutter SDK (3.x or higher)
- Dart SDK (3.x or higher)
- Android Studio / Xcode
- Firebase project configured
- Facebook Developer App configured

## 📱 Platform Configuration

### Android
- Minimum SDK: 21 (recommended)
- Add Internet permission in `AndroidManifest.xml`
- Add Bluetooth permissions for device scanning

### iOS
- Minimum iOS: 12.0
- Add Bluetooth usage description in `Info.plist`
- Configure URL schemes for Google and Facebook sign-in

## 🔐 Required Permissions

### Android (`AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
```

### iOS (`Info.plist`)
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>This app needs Bluetooth to scan for nearby devices</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>This app needs Bluetooth to scan for nearby devices</string>
```

## 📂 Project Structure Details

### Core Layer
- **helper_fun/** - Utility functions (error snackbar, route generation)
- **services/** - App-wide services (Firebase auth, dependency injection, bloc observer)

### Feature Layer
- **auth/** - Authentication feature with login functionality
- **settings/** - Settings and Bluetooth scanning feature

## 🎯 State Management

The app uses **flutter_bloc** with the Cubit pattern:

- `SignInCubit` - Handles authentication states
- `ScanDevicesCubit` - Manages Bluetooth device scanning
