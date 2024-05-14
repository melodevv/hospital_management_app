import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_management_app/Model/user.dart';
import 'package:hospital_management_app/utilities/firebase.dart';

class UserService {
  //get the authenticated userID
  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

  //updates user profile in the Edit Profile Screen
  updateProfile({
    String? firstName,
    String? lastName,
    String? dob,
    String? idNr,
    String? contactNr,
    String? email,
    String? password,
  }) async {
    DocumentSnapshot doc = await usersRef.doc(currentUid()).get();
    var users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    users.firstName = firstName;
    users.lastName = lastName;
    users.dateOfBirth = dob;
    users.idNr = idNr;
    users.contactNr = contactNr;
    users.email = email;
    await usersRef.doc(currentUid()).update({
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dob,
      'idNr': idNr,
      "contactNr": contactNr,
      'email': email
    });

    if (email != firebaseAuth.currentUser!.email &&
        email != null &&
        email != '') {
      await firebaseAuth.currentUser!.verifyBeforeUpdateEmail(email);
    }

    if (password != null && password != '') {
      await firebaseAuth.currentUser!.updatePassword(password);
      await firebaseAuth.currentUser!.reload();
    }

    return true;
  }
}
