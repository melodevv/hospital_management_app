import 'package:flutter/material.dart';
import 'package:hospital_management_app/Model/user.dart';
import 'package:hospital_management_app/routes/route_manager.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/view/widgets/buttons.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:hospital_management_app/viewmodel/auth_viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final String currentUserId = firebaseAuth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
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
                StreamBuilder(
                  stream: usersRef.doc(viewModel.currentUid()).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      UserModel user = UserModel.fromJson(
                          snapshot.data!.data() as Map<String, dynamic>);
                      return TitleText(
                          text: 'Welcome ${user.firstName} ${user.lastName}');
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 30.0),
                LargeButton(
                  label: 'Appointments',
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(RouteManager.appointmentsPage),
                ),
                const SizedBox(height: 5.0),
                LargeButton(
                  label: 'Reviews',
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RouteManager.reviewPage),
                ),
                const SizedBox(height: 5.0),
                LargeButton(
                  label: 'Profile',
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RouteManager.profilePage),
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
