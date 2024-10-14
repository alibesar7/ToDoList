
# ToDoList App

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Firebase Setup](#firebase-setup)
- [Screens](#screens)
  - [Login Screen](#login-screen)
  - [Signup Screen](#signup-screen)
  - [Add Task Screen](#add-task-screen)
  - [Repetitive Tasks Screen](#repetitive-tasks-screen)
- [Contributing](#contributing)
- [License](#license)

## Overview
**ToDoList** is a mobile application for both Android and iOS platforms, built to manage daily tasks efficiently. The app allows users to log in, sign up, add and manage tasks, and quickly add repeated tasks. Firebase is used for authentication and real-time data storage.

## Features
- User Authentication (Login/Signup with Firebase)
- Add New Tasks
- Manage Repetitive Tasks
- Responsive UI for both Android and iOS platforms
- Firebase as Backend for Authentication and Data Management

## Technologies Used
- **Frontend**: Flutter (or React Native) for cross-platform mobile development.
- **Backend**: Firebase (for authentication and database)
- **Database**: Firebase Firestore
- **Authentication**: Firebase Authentication (Email/Password)
- **Cloud Storage**: Firebase Firestore for storing tasks data.

## Installation

### Prerequisites:
- Flutter SDK (or React Native) installed.
- Android Studio and/or Xcode for Android and iOS development.
- Firebase account.

### Steps:
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/ToDoListApp.git
   ```
2. Navigate to the project directory:
   ```bash
   cd ToDoListApp
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Connect your Firebase project (see Firebase Setup below).
5. Run the app:
   ```bash
   flutter run
   ```

## Firebase Setup

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project.
3. Add Android and iOS apps to the project:
   - For Android, download the `google-services.json` file and add it to the `android/app` directory.
   - For iOS, download the `GoogleService-Info.plist` file and add it to the `ios/Runner` directory.
4. Enable Firebase Authentication (Email/Password).
5. Set up Firebase Firestore for tasks storage.
6. Make sure to configure your Firebase SDK in `pubspec.yaml`.

## Screens

### Login Screen
- Users can log in using their email and password.
- Integrated with Firebase Authentication.

### Signup Screen
- Users can sign up for an account using an email and password.
- Data is stored in Firebase Authentication.

### Add Task Screen
- Allows users to create new tasks with task details such as title and description.
- Tasks are stored in Firebase Firestore.

### Repetitive Tasks Screen
- Displays a list of predefined repetitive tasks for quick access.
- Users can easily add repetitive tasks to their main list.

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
