import 'package:flutter/material.dart';
import 'package:hospital_management_app/routes/route_manager.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/view/widgets/buttons.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:hospital_management_app/viewmodel/auth_viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      key: viewModel.scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Hospital Management App'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: appSidePadding,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Image(
                  width: MediaQuery.of(context).size.width,
                  image: const AssetImage('assets/images/logo.png'),
                ),
                const SizedBox(height: 50.0),
                const TitleText(text: 'Admin Portal'),
                const SizedBox(height: 30.0),
                LargeButton(
                  label: 'Appointments',
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(RouteManager.viewAppointmentsPage),
                ),
                const SizedBox(height: 5.0),
                LargeButton(
                  label: 'Reviews',
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(RouteManager.viewReviewPage),
                ),
                const SizedBox(height: 30.0),
                LargeButton(
                  label: 'Logout',
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => viewModel.logoutUser(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
