import 'package:flutter/material.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/utilities/validations.dart';
import 'package:hospital_management_app/view/widgets/buttons.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';
import 'package:hospital_management_app/view/widgets/password_form.dart';
import 'package:hospital_management_app/view/widgets/text_form.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:hospital_management_app/viewmodel/auth_viewmodels/admin_register.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class AdminRegisterPage extends StatefulWidget {
  const AdminRegisterPage({super.key});

  @override
  State<AdminRegisterPage> createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
  @override
  Widget build(BuildContext context) {
    AdminRegisterViewModel viewModel =
        Provider.of<AdminRegisterViewModel>(context);
    return LoadingOverlay(
      isLoading: viewModel.loading,
      progressIndicator: circularProgress(context),
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Hospital Management App'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: appSidePadding,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Image(
                  width: MediaQuery.of(context).size.width,
                  image: const AssetImage('assets/images/logo.png'),
                ),
                const SizedBox(height: 30.0),
                const TitleText(text: 'Admin Register'),
                const SizedBox(height: 50.0),
                buildForm(viewModel, context),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'I am already registered.',
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildForm(AdminRegisterViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Icons.mail,
            hintText: "Email",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel.setEmail(val);
            },
            focusNode: viewModel.emailFN,
            nextFocusNode: viewModel.passwordFN,
          ),
          const SizedBox(height: 10.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Icons.lock,
            suffix: Icons.remove_red_eye,
            hintText: "Password",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validatePassword,
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
            focusNode: viewModel.passwordFN,
            nextFocusNode: viewModel.cPasswordFN,
          ),
          const SizedBox(height: 10.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Icons.lock,
            suffix: Icons.remove_red_eye,
            hintText: "Confirm Password",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validatePassword,
            submitAction: () => viewModel.register(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setCPassword(val);
            },
            focusNode: viewModel.cPasswordFN,
          ),
          const SizedBox(height: 25.0),
          LargeButton(
            label: 'Register',
            color: Theme.of(context).colorScheme.primary,
            onPressed: () => viewModel.register(context),
          ),
        ],
      ),
    );
  }
}
