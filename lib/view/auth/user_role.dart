import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/view/admin_portal/admin_panel.dart';
import 'package:hospital_management_app/view/patient_portal/main_page.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';

class UserRoleCheck extends StatelessWidget {
  final String uid;

  const UserRoleCheck({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: adminsRef.doc(uid).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Theme.of(context).colorScheme.primary,
            child: Center(
              child: circularProgress(context),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data!.exists) {
            // User exists in admin collection, take them to homepage
            return const AdminDashboardPage();
          } else {
            // User does not exist in admin collection, take them to dashboard
            return const MainPage();
          }
        }
      },
    );
  }
}
