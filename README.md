# Zini Pay SMS Sync App

## Overview

This Flutter application is designed to sync incoming SMS messages to a remote server. It features a login system and background SMS syncing capabilities.

## Features

- User authentication
- Background SMS syncing
- Persistent notification for active syncing
- Offline support with automatic re-sync when online

## Requirements

- Flutter SDK (latest stable version)
- Android Studio or VS Code with Flutter extensions
- iOS development setup (for iOS deployment)

## Setup

1. Clone the repository:
   ```
   git clone https://github.com/tfinity/zinipay-demo-task
   ```

2. Navigate to the project directory:
   ```
   cd zinipay-demo-task
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart
|__ core/
├── screens/
│   ├── login_screen.dart
│   └── home_screen.dart
|   └── wisgets/
├── services/
│   ├── auth_service.dart
│   └── sms_service.dart
|   └── background_service.dart
|   └── api_service.dart
├── models/
│   └── sms_message.dart
└── utils/
    └── background_service.dart
```

## Running the App

1. Start an Android emulator or connect an Android device.
2. Run the app using:
   ```
   flutter run
   ```

## Building the APK

To build the APK, run:
```
flutter build apk
```
The APK will be available at `build/app/outputs/flutter-apk/app-release.apk`.

## iOS Build

For iOS, run:
```
flutter build ios
```
Then open the Xcode project in the `ios/` folder to archive and distribute the app.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.