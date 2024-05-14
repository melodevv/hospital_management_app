import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospital_management_app/utilities/firebase.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get the current logged in user
  User getCurrentUser() {
    User user = firebaseAuth.currentUser!;
    return user;
  }

  // Create a new user
  Future<bool> createNewUser({
    required String? firstName,
    required String? lastName,
    required String? dob,
    required String? idNr,
    required String? contactNr,
    required String? email,
    required String? password,
  }) async {
    UserCredential usercredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: '$email',
      password: '$password',
    );

    if (usercredential.user != null) {
      // account creation was successful
      await saveUserToFirestore(
        firstName: firstName!,
        lastName: lastName!,
        user: usercredential.user!,
        email: email!,
        contactNr: contactNr!,
        dob: dob!,
        idNr: idNr!,
      );
      return true;
    } else {
      // account creation was not successful
      return false;
    }
  }

  //this will save the details inputted by the user to firestore.
  saveUserToFirestore({
    required String firstName,
    required String lastName,
    required User user,
    required String contactNr,
    required String idNr,
    required String dob,
    required String email,
  }) async {
    await usersRef.doc(user.uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'id': user.uid,
      'dateOfBirth': dob,
      'idNr': idNr,
      'contactNr': contactNr,
    });
  }

  // Create a new admin
  Future<bool> createNewAdmin({
    required String? email,
    required String? password,
  }) async {
    UserCredential usercredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: '$email',
      password: '$password',
    );

    if (usercredential.user != null) {
      // account creation was successful
      await saveAdminToFirestore(
        user: usercredential.user!,
        email: email!,
      );
      return true;
    } else {
      // account creation was not successful
      return false;
    }
  }

  //this will save the details inputted by the user to firestore.
  saveAdminToFirestore({
    required User user,
    required String email,
  }) async {
    await adminsRef.doc(user.uid).set({
      'email': email,
      'id': user.uid,
    });
  }

  Future<bool> loginUser({String? email, String? password}) async {
    var res = await firebaseAuth.signInWithEmailAndPassword(
      email: '$email',
      password: '$password',
    );

    if (res.user != null) {
      // account login was successful
      return true;
    } else {
      // account login was not successful
      return false;
    }
  }

  forgotPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  logOut() async {
    await firebaseAuth.signOut();
  }

  // Error Messages Handeler
  String handleFirebaseAuthError(String e) {
    if (e.contains("ERROR_WEAK_PASSWORD")) {
      return "Password is too weak";
    } else if (e.contains("invalid-email")) {
      return "Invalid Email";
    } else if (e.contains("ERROR_EMAIL_ALREADY_IN_USE") ||
        e.contains('email-already-in-use')) {
      return "The email address is already in use by another account.";
    } else if (e.contains("ERROR_NETWORK_REQUEST_FAILED")) {
      return "Network error occured!";
    } else if (e.contains("ERROR_USER_NOT_FOUND") ||
        e.contains('firebase_auth/user-not-found')) {
      return "Invalid credentials.";
    } else if (e.contains("ERROR_WRONG_PASSWORD") ||
        e.contains('wrong-password')) {
      return "Invalid credentials.";
    } else if (e.contains("INVALID_LOGIN_CREDENTIALS") ||
        e.contains('wrong-password')) {
      return "Invalid credentials.";
    } else if (e.contains('firebase_auth/requires-recent-login')) {
      return 'This operation is sensitive and requires recent authentication.'
          ' Log in again before retrying this request.';
    } else if (e.contains('firebase_auth/network-request-failed')) {
      return 'Please check your internet connection.';
    } else {
      return e;
    }
  }
}
