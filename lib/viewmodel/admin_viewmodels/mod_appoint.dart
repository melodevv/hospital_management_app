// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hospital_management_app/service/data_service.dart';
import 'package:hospital_management_app/view/widgets/snackbar.dart';

class ModAppointmentViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  DataService dataService = DataService();
  String? _id, _reason, _dateTime;

  setId(id) {
    _id = id;
    notifyListeners(); // Notify listeners when email changes
  }

  setReason(reason) {
    _reason = reason;
    notifyListeners(); // Notify listeners when email changes
  }

  setDateTime(dateTime) {
    _dateTime = dateTime;
    notifyListeners(); // Notify listeners when email changes
  }

  modifyAppointment(BuildContext context, String docId) async {
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
        bool success = await dataService.updateAppointment(
          docId: docId,
          id: _id,
          dateTime: _dateTime,
          reason: _reason,
        );
        // print(success);
        if (success) {
          showInSnackBar('Appointment Updated',
              Theme.of(context).colorScheme.primary, context);
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

  deleteAppointment(BuildContext context, docID) async {
    loading = true;
    notifyListeners();
    try {
      bool success = await dataService.deleteAppointment(docId: docID);
      // print(success);
      if (success) {
        notifyListeners();
        showInSnackBar('Appointment Deleted',
            Theme.of(context).colorScheme.primary, context);
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
