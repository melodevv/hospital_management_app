// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hospital_management_app/routes/route_manager.dart';
import 'package:hospital_management_app/service/user.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/view/widgets/snackbar.dart';

class ProfileViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  UserService userService = UserService();
  String? _fname,
      _lname,
      _email,
      _password,
      _cPassword,
      _dob,
      _idNr,
      _contactNr;

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

  editProfile(BuildContext context) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('Please fix the errors in red before submitting.',
          Theme.of(context).colorScheme.error, context);
    } else {
      if (_password == _cPassword) {
        loading = true;
        notifyListeners();
        try {
          bool success = await userService.updateProfile(
            //  user: user,
            firstName: _fname,
            lastName: _lname,
            dob: _dob,
            idNr: _idNr,
            contactNr: _contactNr,
            email: _email,
            password: _password,
          );
          // print(success);
          if (success) {
            showInSnackBar('Your Profile Details Have been Updated',
                Theme.of(context).colorScheme.primary, context);
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(RouteManager.profilePage);
            _password = null;
            _cPassword = null;
          }
        } catch (e) {
          loading = false;
          notifyListeners();
          showInSnackBar(
              e.toString(), Theme.of(context).colorScheme.error, context);
          // print(e);
        }
        loading = false;
        notifyListeners();
      } else {
        showInSnackBar('The passwords do not match',
            Theme.of(context).colorScheme.error, context);
      }
    }
  }
}
