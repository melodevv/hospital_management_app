import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/firebase_options.dart';
import 'package:hospital_management_app/routes/route_manager.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/view/auth/login_page.dart';
import 'package:hospital_management_app/view/auth/user_role.dart';
import 'package:hospital_management_app/viewmodel/auth_viewmodels/admin_register.dart';
import 'package:hospital_management_app/viewmodel/admin_viewmodels/mod_appoint.dart';
import 'package:hospital_management_app/viewmodel/admin_viewmodels/mod_review.dart';
import 'package:hospital_management_app/viewmodel/patient_viewmodels/appointments_viewmodel.dart';
import 'package:hospital_management_app/viewmodel/auth_viewmodels/forgot_pass_viewmodel.dart';
import 'package:hospital_management_app/viewmodel/auth_viewmodels/login_viewmodel.dart';
import 'package:hospital_management_app/viewmodel/patient_viewmodels/profile_viewmodel.dart';
import 'package:hospital_management_app/viewmodel/auth_viewmodels/register_viewmodel.dart';
import 'package:hospital_management_app/viewmodel/patient_viewmodels/review_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AdminRegisterViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => ForgotPassViewModel()),
        ChangeNotifierProvider(create: (context) => AppointmentsViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => ReviewsViewModel()),
        ChangeNotifierProvider(create: (context) => ModAppointmentViewModel()),
        ChangeNotifierProvider(create: (context) => ModReviewsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: FlexThemeData.light(scheme: FlexScheme.money),
        home: StreamBuilder(
          stream: firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            // check if user signed in
            if (snapshot.hasData) {
              return UserRoleCheck(
                uid: snapshot.data!.uid,
              );
            } else {
              // user not loggedin
              return const LoginPage();
            }
          },
        ),
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
