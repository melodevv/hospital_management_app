// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'package:flutter/material.dart';
import 'package:hospital_management_app/service/auth.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/view/widgets/snackbar.dart';

class RegisterViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? _fname,
      _lname,
      _email,
      _password,
      _cPassword,
      _dob,
      _idNr,
      _contactNr;

  bool validate = false, loading = false;
  FocusNode fnameFN = FocusNode();
  FocusNode lnameFN = FocusNode();
  FocusNode dobFN = FocusNode();
  FocusNode idNrFN = FocusNode();
  FocusNode contactNrFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode passwordFN = FocusNode();
  FocusNode cPasswordFN = FocusNode();
  AuthService auth = AuthService();

  // Set First Name
  setFirstName(fname) {
    _fname = fname;
    notifyListeners(); // Notify listeners when email changes
  }

  // Set Last Name
  setLastName(lname) {
    _lname = lname;
    notifyListeners(); // Notify listeners when email changes
  }

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

  // Set Date of Birth
  setDob(dob) {
    _dob = dob;
    notifyListeners(); // Notify listeners when email changes
  }

  // Set ID Number
  setId(idnr) {
    _idNr = idnr;
    notifyListeners(); // Notify listeners when email changes
  }

  // Set Contact Number
  setContactNr(contactnr) {
    _contactNr = contactnr;
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
          bool success = await auth.createNewUser(
            firstName: _fname,
            lastName: _lname,
            email: _email,
            password: _password,
            dob: _dob,
            idNr: _idNr,
            contactNr: _contactNr,
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
    _fname = null;
    _lname = null;
    _email = null;
    _password = null;
    _dob = null;
    _idNr = null;
    _contactNr = null;
  }
}
