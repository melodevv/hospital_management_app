import 'package:flutter/material.dart';
import 'package:hospital_management_app/Model/user.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/utilities/validations.dart';
import 'package:hospital_management_app/view/widgets/buttons.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';
import 'package:hospital_management_app/view/widgets/password_form.dart';
import 'package:hospital_management_app/view/widgets/text_form.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:hospital_management_app/viewmodel/patient_viewmodels/profile_viewmodel.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    ProfileViewModel viewModel = Provider.of<ProfileViewModel>(context);
    return LoadingOverlay(
      isLoading: viewModel.loading,
      progressIndicator: circularProgress(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: appSidePadding,
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                const TitleText(text: 'Update Profile'),
                const SizedBox(height: 50.0),
                StreamBuilder(
                  stream: usersRef.doc(viewModel.currentUid()).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      UserModel user = UserModel.fromJson(
                          snapshot.data!.data() as Map<String, dynamic>);
                      return buildForm(viewModel, user, context);
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  buildForm(ProfileViewModel viewModel, UserModel user, BuildContext context) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormBuilder(
            initialValue: user.firstName,
            enabled: !viewModel.loading,
            prefix: Icons.person,
            hintText: "First name",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateFName,
            onSaved: (String val) {
              viewModel.setFirstName(val);
            },
          ),
          const SizedBox(height: 10.0),
          TextFormBuilder(
            initialValue: user.lastName,
            enabled: !viewModel.loading,
            prefix: Icons.person,
            hintText: "Last name",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateLName,
            onSaved: (String val) {
              viewModel.setLastName(val);
            },
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: TextFormBuilder(
                  enabled: !viewModel.loading,
                  prefix: Icons.calendar_month_rounded,
                  controller: TextEditingController(
                    text: selectedDate != null
                        ? "${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}"
                        : user.dateOfBirth,
                  ),
                  hintText: "Date of Birth",
                  textInputAction: TextInputAction.next,
                  validateFunction: Validations.validateDob,
                  onSaved: (String val) {
                    viewModel.setDob(val);
                  },
                ),
              ),
              MaterialButton(
                minWidth: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  _selectDate(context);
                },
                child: const Icon(Icons.calendar_month_rounded),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          TextFormBuilder(
            initialValue: user.idNr,
            enabled: !viewModel.loading,
            prefix: Icons.person,
            hintText: "ID Number",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateIdNr,
            onSaved: (String val) {
              viewModel.setId(val);
            },
          ),
          const SizedBox(height: 10.0),
          TextFormBuilder(
            initialValue: user.contactNr,
            enabled: !viewModel.loading,
            prefix: Icons.person,
            hintText: "Contact Number",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validationContact,
            onSaved: (String val) {
              viewModel.setContactNr(val);
            },
          ),
          const SizedBox(height: 10.0),
          TextFormBuilder(
            initialValue: user.email,
            enabled: !viewModel.loading,
            prefix: Icons.mail,
            hintText: "Email",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel.setEmail(val);
            },
          ),
          const SizedBox(height: 10.0),
          PasswordFormBuilder(
            initialValue: null,
            enabled: !viewModel.loading,
            prefix: Icons.lock,
            suffix: Icons.remove_red_eye,
            hintText: "Password",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateUPassword,
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
          ),
          const SizedBox(height: 10.0),
          PasswordFormBuilder(
            initialValue: null,
            enabled: !viewModel.loading,
            prefix: Icons.lock,
            suffix: Icons.remove_red_eye,
            hintText: "Confirm Password",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validateUPassword,
            submitAction: () => viewModel.editProfile(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setCPassword(val);
            },
          ),
          const SizedBox(height: 25.0),
          LargeButton(
            label: 'Update Profile',
            color: Theme.of(context).colorScheme.primary,
            onPressed: () => viewModel.editProfile(context),
          ),
        ],
      ),
    );
  }
}
