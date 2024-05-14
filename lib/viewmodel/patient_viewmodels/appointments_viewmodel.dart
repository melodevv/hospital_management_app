import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/Model/user.dart';
import 'package:hospital_management_app/service/auth.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/view/widgets/snackbar.dart';

class AppointmentsViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? _dateTime, _reason;
  AuthService auth = AuthService();

  // Setters
  setDateTime(dateTime) {
    _dateTime = dateTime;
    notifyListeners(); // Notify listeners when email changes
  }

  setReason(reason) {
    _reason = reason;
    notifyListeners(); // Notify listeners when email changes
  }

  // reset the provided values
  resetValues() {
    _dateTime = null;
    _reason = null;
  }

  //get the authenticated uis
  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

  setAppointment(BuildContext context) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('Please fix the errors in red before submitting.',
          Theme.of(context).colorScheme.error, context);
    } else {
      loading = true;
      notifyListeners();

      try {
        DocumentSnapshot doc = await usersRef.doc(currentUid()).get();
        var userData = UserModel.fromJson(doc.data() as Map<String, dynamic>);

        await appointmentsRef.add({
          'id': currentUid(),
          'dateTime': _dateTime,
          'reason': _reason,
        });

        // Show snackbar on success
        showInSnackBar(
            '${userData.firstName} ${userData.lastName}, your appointment is received',
            Theme.of(context).colorScheme.primary,
            context);
      } catch (e) {
        loading = false;
        notifyListeners();
        showInSnackBar(auth.handleFirebaseAuthError(e.toString()),
            Theme.of(context).colorScheme.error, context);
      }

      loading = false;
      notifyListeners();
    }
  }
}
