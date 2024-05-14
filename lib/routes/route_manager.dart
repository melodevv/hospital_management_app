import 'package:flutter/material.dart';
import 'package:hospital_management_app/view/admin_portal/admin_panel.dart';
import 'package:hospital_management_app/view/admin_portal/modify_appointments.dart';
import 'package:hospital_management_app/view/admin_portal/modify_reviews.dart';
import 'package:hospital_management_app/view/admin_portal/veiw_reviews.dart';
import 'package:hospital_management_app/view/admin_portal/view_appointments.dart';
import 'package:hospital_management_app/view/auth/admin_register.dart';
import 'package:hospital_management_app/view/auth/forgot_password.dart';
import 'package:hospital_management_app/view/auth/login_page.dart';
import 'package:hospital_management_app/view/auth/register_page.dart';
import 'package:hospital_management_app/view/patient_portal/appointments_page.dart';
import 'package:hospital_management_app/view/patient_portal/main_page.dart';
import 'package:hospital_management_app/view/patient_portal/profile_page.dart';
import 'package:hospital_management_app/view/patient_portal/review_page.dart';

class RouteManager {
  // auth routes
  static const loginPage = '/loginPage';
  static const registerPage = '/registerPage';
  static const adminRegisterPage = '/adminRegisterPage';
  static const forgotPasswordPage = '/forgotPasswordPage';

  // patient portal routes
  static const mainPage = '/';
  static const appointmentsPage = '/appointmentsPage';
  static const profilePage = '/profilePage';
  static const reviewPage = '/reviewPage';

  // admin dashboard routes
  static const adminPage = '/adminPage';
  static const viewAppointmentsPage = '/viewAppointmentsPage';
  static const viewReviewPage = '/viewReviewPage';
  static const modAppointmentsPage = '/modAppointmentsPage';
  static const modReviewPage = '/modReviewPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainPage:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        );
      case adminRegisterPage:
        return MaterialPageRoute(
          builder: (context) => const AdminRegisterPage(),
        );
      case forgotPasswordPage:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordPage(),
        );
      case appointmentsPage:
        return MaterialPageRoute(
          builder: (context) => const AppointmentsPage(),
        );
      case reviewPage:
        return MaterialPageRoute(
          builder: (context) => const ReviewPage(),
        );
      case profilePage:
        return MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        );
      case adminPage:
        return MaterialPageRoute(
          builder: (context) => const AdminDashboardPage(),
        );
      case viewAppointmentsPage:
        return MaterialPageRoute(
          builder: (context) => const ViewAppointments(),
        );
      case viewReviewPage:
        return MaterialPageRoute(
          builder: (context) => const ViewReviews(),
        );
      case modAppointmentsPage:
        final MyArguments uid = settings.arguments as MyArguments;
        return MaterialPageRoute(
          builder: (context) => ModAppointmentsPage(arguments: uid),
        );
      case modReviewPage:
        final MyArguments uid = settings.arguments as MyArguments;
        return MaterialPageRoute(
          builder: (context) => ModReviewsPage(arguments: uid),
        );
      default:
        throw const FormatException('Route not found, check routes again');
    } // end of switch
  } // end generateRoute method
} // end class

class MyArguments {
  final String uid;

  MyArguments(this.uid);
}
