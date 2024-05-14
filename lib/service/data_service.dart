import 'package:hospital_management_app/utilities/firebase.dart';

class DataService {
  updateAppointment({
    String? dateTime,
    String? reason,
    String? id,
    String? docId,
  }) async {
    await appointmentsRef.doc(docId).update({
      'dateTime': dateTime,
      'reason': reason,
    });

    return true;
  }

  deleteAppointment({
    String? docId,
  }) async {
    await appointmentsRef.doc(docId).delete();
    return true;
  }

  updateReview({
    String? review,
    String? hospitalName,
    String? id,
    String? docId,
  }) async {
    await reviewsRef.doc(docId).update({
      'hospitalName': hospitalName,
      'review': review,
    });

    return true;
  }

  deleteReview({
    String? docId,
  }) async {
    await reviewsRef.doc(docId).delete();
    return true;
  }
}
