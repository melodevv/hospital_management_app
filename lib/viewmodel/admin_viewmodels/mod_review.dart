// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hospital_management_app/service/data_service.dart';
import 'package:hospital_management_app/view/widgets/snackbar.dart';

class ModReviewsViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? _id, _hospitalName, _review;
  DataService dataService = DataService();

  // Setters
  setId(id) {
    _id = id;
    notifyListeners(); // Notify listeners when email changes
  }

  setHospitalName(hospitalName) {
    _hospitalName = hospitalName;
    notifyListeners(); // Notify listeners when email changes
  }

  setReview(review) {
    _review = review;
    notifyListeners(); // Notify listeners when email changes
  }

  modifyReview(BuildContext context, String docId) async {
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
        bool success = await dataService.updateReview(
          docId: docId,
          id: _id,
          review: _review,
          hospitalName: _hospitalName,
        );
        // print(success);
        if (success) {
          showInSnackBar(
              'Review Updated', Theme.of(context).colorScheme.primary, context);
          Navigator.of(context).pop();
        }
      } catch (e) {
        loading = false;
        notifyListeners();
        showInSnackBar(
            e.toString(), Theme.of(context).colorScheme.error, context);
      }

      loading = false;
      notifyListeners();
    }
  }

  deleteReview(BuildContext context, docID) async {
    loading = true;
    notifyListeners();
    try {
      bool success = await dataService.deleteReview(docId: docID);
      // print(success);
      if (success) {
        showInSnackBar(
            'Review Deleted', Theme.of(context).colorScheme.primary, context);
        Navigator.of(context).pop();
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
  }
}
