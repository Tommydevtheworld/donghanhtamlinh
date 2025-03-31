# Flutter Plugin for Android Studio: Quick Setup Guide

A concise guide to installing, configuring, and using the Flutter plugin in Android Studio for Flutter app development.

## Prerequisites

- **Android Studio**: Installed and updated ([download here](https://developer.android.com/studio))
- **Flutter SDK**: Downloaded and extracted ([download here](https://flutter.dev/docs/get-started/install))

## Step 1: Install the Flutter Plugin

1. **Open Android Studio**
2. **Access Plugins**:
   - Windows/Linux: `File > Settings > Plugins`
   - macOS: `Android Studio > Preferences > Plugins`
3. **Install Flutter Plugin**:
   - Search for "Flutter" in the Marketplace
   - Click "Install" (this will also install the Dart plugin)
4. **Restart Android Studio** when prompted

## Step 2: Configure Flutter SDK

1. **Set SDK Path**:
   - Go to `File > Settings > Languages & Frameworks > Flutter` (or `Preferences` on macOS)
   - Enter your Flutter SDK path (e.g., `~/development/flutter`)
   - Click "Apply" and "OK"

2. **Verify Setup**:
   - Open the terminal in Android Studio (View > Tool Windows > Terminal)

```bash
flutter doctor
```

3. **Fix Issues** if any are reported by Flutter Doctor

## Step 3: Create a Flutter Project

### New Project
1. Click `File > New > New Flutter Project`
2. Select "Flutter Application" and click "Next"
3. Configure project:
   - Verify Flutter SDK path
   - Enter project name (e.g., `my_flutter_app`)
   - Choose project location
   - Enter description (optional)
4. Click "Finish"

### Open Existing Project
- Click `File > Open` and navigate to your Flutter project folder

## Step 4: Run and Debug

### Set Up a Device
- **Emulator**:
   - Go to `Tools > Device Manager`
   - Click "Create Device", choose a phone, select an Android version
   - Start it with the play button
- **Physical Device**:
   - Enable USB Debugging on your device
   - Connect via USB and authorize when prompted

### Run Your App
1. Select your target device from the dropdown in the toolbar
2. Click the green "Run" button (▶️) or press `Shift + F10`

### Key Debugging Features
- **Hot Reload**: Click the lightning bolt (⚡) or press `Ctrl + \` (macOS: `Cmd + \`)
- **Hot Restart**: Click the refresh icon or press `Shift + F5`
- **Breakpoints**: Click in the gutter next to code line numbers
- **Debug Panel**: Access via `View > Tool Windows > Debug`

## Flutter Plugin Features

### Code Assistance
- Code completion for Dart and Flutter APIs
- Live templates (try typing `stless` and press Tab)
- Error highlighting and quick-fixes

### Flutter Inspector
- Access via `View > Tool Windows > Flutter Inspector` when app is running
- Examine widget tree
- Identify layout issues

### Flutter Outline
- View widget structure in `View > Tool Windows > Flutter Outline`
- Quickly wrap widgets using the context menu

### Performance Profiling
- Access via `View > Tool Windows > Flutter Performance`
- Monitor app performance metrics while running

## Keyboard Shortcuts

| Action | Windows/Linux | macOS |
|--------|---------------|-------|
| Run app | `Shift + F10` | `Ctrl + R` |
| Hot reload | `Ctrl + \` | `Cmd + \` |
| Hot restart | `Shift + F5` | `Cmd + Shift + R` |
| Format code | `Ctrl + Alt + L` | `Cmd + Alt + L` |
| Find action | `Ctrl + Shift + A` | `Cmd + Shift + A` |
