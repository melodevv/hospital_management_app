// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:hospital_management_app/service/auth.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/view/widgets/snackbar.dart';

class AdminRegisterViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? _email, _password, _cPassword;

  bool validate = false, loading = false;
  FocusNode emailFN = FocusNode();
  FocusNode passwordFN = FocusNode();
  FocusNode cPasswordFN = FocusNode();
  AuthService auth = AuthService();

  // Set Email
  setEmail(email) {
    _email = email;
    notifyListeners(); // Notify listeners when email changes
  }

  // Set Password
  setPassword(password) {
    _password = password;
    notifyListeners(); // Notify listeners when email changes
  }

  // Set Password
  setCPassword(cpassword) {
    _cPassword = cpassword;
    notifyListeners(); // Notify listeners when email changes
  }

  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

  register(BuildContext context) async {
    FormState form = formKey.currentState!;
    form.save();

    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('Please fix the errors in red before submitting',
          Theme.of(context).colorScheme.error, context);
    } else {
      if (_password == _cPassword) {
        loading = true;
        notifyListeners();

        // try and create the new user account on database
        try {
          bool success = await auth.createNewAdmin(
            email: _email,
            password: _password,
          );
          if (success) {
            Navigator.of(context).pop();
            resetValues();
          }
        } catch (e) {
          loading = false;
          notifyListeners();
          showInSnackBar(auth.handleFirebaseAuthError(e.toString()),
              Theme.of(context).colorScheme.error, context);
        }
        loading = false;
        notifyListeners();
      } else {
        showInSnackBar('The passwords do not match',
            Theme.of(context).colorScheme.error, context);
      }
    }
  }

  // reset the provided values
  resetValues() {
    _email = null;
    _password = null;
  }
}
