// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/Model/user.dart';
import 'package:hospital_management_app/service/auth.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/view/widgets/snackbar.dart';

class ReviewsViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? _hospitalName, _review;
  AuthService auth = AuthService();

  // Setters
  setHospitalName(hospitalName) {
    _hospitalName = hospitalName;
    notifyListeners(); // Notify listeners when email changes
  }

  setReview(review) {
    _review = review;
    notifyListeners(); // Notify listeners when email changes
  }

  // reset the provided values
  resetValues() {
    _hospitalName = null;
    _review = null;
  }

  //get the authenticated uis
  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

  submitReview(BuildContext context) async {
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

        await reviewsRef.add({
          'id': currentUid(),
          'hospitalName': _hospitalName,
          'review': _review,
        });

        // Show snackbar on success
        showInSnackBar(
            '${userData.firstName} ${userData.lastName}, your review is received',
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
