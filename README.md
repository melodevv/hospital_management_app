# Hospital Management App

## Overview

The **Hospital Management App** is a mobile application designed for efficiently managing patient appointments, reviews, and admin interactions. It enables users to book appointments, provide reviews for the services, and allows administrators to manage and view these details. 

This application leverages **Flutter** for the frontend and **Firebase** for authentication and data storage, providing a seamless experience for both users and administrators.

---

## Features

### 🌟 User Features:
- **Sign Up / Login**: Secure authentication using Firebase Authentication.
- **Book Appointments**: Users can schedule appointments with doctors.
- **Leave Reviews**: After consultations, users can leave reviews for services.
- **View Appointments**: Track the status and schedule of booked appointments.
- **View Review**: See the review they have created.
  
### 🛠 Admin Features:
- **Sign Up / Login**: Secure authentication using Firebase Authentication.
- **View Appointments**: Admins can read all the appointments made by users.
- **Manage Reviews**: Admins can view and manage user reviews.

---

## Technologies Used

- **Frontend**: Flutter
- **Backend**: Dart and Firebase
- **State Management**: Provider (or any state management solution you prefer)
- **Authentication**: Firebase Auth
- **Database**: Firebase Firestore (for storing appointments and reviews)

---

## Installation & Setup

### Prerequisites:
- Flutter installed on your machine
- Firebase project set up (with Firestore and Firebase Authentication enabled)

### Steps:
1. Clone the repository:
    ```bash
    git clone https://github.com/melodevv/hospital_management_app.git
    cd hospital_management_app
    ```

2. Install dependencies:
    ```bash
    flutter pub get
    ```

3. Set up Firebase:
    - Go to the [Firebase Console](https://console.firebase.google.com/), create a project, and follow the instructions to add Firebase to your Flutter app.
    - Add your `google-services.json` for Android and/or `GoogleService-Info.plist` for iOS to the respective directories.

4. Run the app:
    ```bash
    flutter run
    ```

---

## Firebase Setup

Make sure you have completed the following steps in Firebase:

- Enable **Firebase Authentication** (Email/Password method).
- Create a **Firestore database** and set up collections for appointments and reviews (you can use Firestore rules to manage security).

---


