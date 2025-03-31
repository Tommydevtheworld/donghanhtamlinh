# Flutter App Deployment Guide

This guide walks you through deploying Flutter applications on iOS and Android platforms, covering simulator/emulator testing, real device testing, and production deployment.

## Prerequisites

- **Flutter SDK**: Installed (e.g., ~/development/flutter)
- **Xcode**: Installed (for iOS and macOS)
- **Android Studio**: Installed (for Android)
- **Physical Devices**: iPhone and Android phone (optional for real device testing)
- **Apple ID**: For iOS signing (free for testing, paid for deployment)
- **Google Play Account**: For Android deployment (requires a one-time $25 fee)

Verify your setup is complete:

```bash
flutter doctor
```

## Part 1: Build and Test on Simulated Devices

### iOS Simulator

#### Setup

1. Install Xcode from the Mac App Store
2. Open Xcode and install components:

```bash
sudo xcode-select --install
```

```bash
xcodebuild -runFirstLaunch
```

3. Add a Simulator:
    - Open Xcode > Open Developer Tool > Simulator
    - Add a device via File > New Simulator

#### Build and Test

1. Navigate to your project:

```bash
cd /path/to/your_flutter_project
```

2. Install iOS dependencies:

```bash
cd ios
```

```bash
pod install
```

```bash
cd ..
```

3. List available devices:

```bash
flutter devices
```

4. Run on simulator:

```bash
flutter run -d "iPhone 15"
```

### Android Emulator

#### Setup

1. Install Android Studio:
    - Download from developer.android.com
    - Install on macOS:

```bash
unzip android-studio-*.zip -d /Applications
```

2. Set Up Android SDK:
    - Open Android Studio > Configure > SDK Manager
    - Install Android SDK and Android Emulator

3. Create an Emulator:
    - Go to Tools > Device Manager
    - Click "Create Device," choose a phone, and select an API level

#### Build and Test

1. Start Emulator from Android Studio Device Manager

2. Navigate to your project:

```bash
cd /path/to/your_flutter_project
```

3. List available devices:

```bash
flutter devices
```

4. Run on emulator:

```bash
flutter run -d "emulator-5554"
```

## Part 2: Build and Test on Real Devices

### iOS (Real iPhone)

#### Setup

1. Connect iPhone to your Mac via USB, unlock it, and trust the computer

2. Configure Xcode:
    - Open iOS project in Xcode:

```bash
open ios/Runner.xcworkspace
```

- Go to Runner > Signing & Capabilities
- Enable "Automatically manage signing"
- Add your Apple ID (Xcode > Preferences > Accounts)
- Set a unique Bundle Identifier (e.g., com.yourname.myapp)

#### Build and Test

1. List connected devices:

```bash
flutter devices
```

2. Run on your iPhone:

```bash
flutter run -d "John's iPhone"
```

3. Trust Developer (first time):
    - On iPhone: Settings > General > VPN & Device Management > Trust your Apple ID

### Android (Real Phone)

#### Setup

1. Enable Developer Options:
    - On your Android phone: Settings > About Phone > Tap Build Number 7 times
    - Go to Settings > Developer Options > Enable USB Debugging

2. Connect Phone via USB and allow USB debugging when prompted

#### Build and Test

1. List connected devices:

```bash
flutter devices
```

2. Run on your phone:

```bash
flutter run -d "Samsung A51"
```

## Part 3: Build for Real Deployment

### iOS (App Store)

#### Setup

1. Join Apple Developer Program ($99/year) at developer.apple.com

2. Create Certificates and Profiles in your Apple Developer account:
    - Create an App ID (match your Bundle Identifier)
    - Generate a Distribution Certificate
    - Create a Provisioning Profile (App Store type)
    - Download and add them to Xcode

#### Build Release

1. Update App Info in ios/Runner/Info.plist

2. Build IPA:

```bash
flutter build ios --release
```

3. Archive in Xcode:
    - Open ios/Runner.xcworkspace
    - Set device to "Any iOS Device" (top-left dropdown)
    - Go to Product > Archive
    - In the Organizer (Window > Organizer), click "Distribute App" > "App Store Connect" > Export .ipa

4. Upload to App Store via App Store Connect or Transporter

### Android (Google Play)

#### Setup

1. Sign Up for Google Play ($25 one-time) at play.google.com/console

2. Generate a Signing Key:

```bash
keytool -genkey -v -keystore ~/my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-alias
```

3. Configure Signing:
    - Create android/key.properties with your key details
    - Edit android/app/build.gradle to include signing configuration

#### Build Release

1. Build App Bundle (recommended for Google Play):

```bash
flutter build appbundle --release
```

2. Build APK (alternative for sideloading):

```bash
flutter build apk --release
```

3. Upload to Google Play Console

## Quick Reference

| Platform | Simulator/Emulator | Real Device | Release Build |
|----------|-------------------|-------------|---------------|
| iOS | `flutter run -d "iPhone 15"` | `flutter run -d "John's iPhone"` | `flutter build ios`, then Xcode Archive |
| Android | `flutter run -d "emulator-5554"` | `flutter run -d "Samsung A51"` | `flutter build appbundle` |

## Troubleshooting Tips

- **Clean Builds**: If errors occur, run:

```bash
flutter clean
```

```bash
flutter pub get
```

- **Verbose Output**: Use `flutter run -v` or `flutter build -v` for debugging
- **Deployment**: Ensure app icons, version numbers, and permissions are set in Info.plist (iOS) and AndroidManifest.xml (Android)
