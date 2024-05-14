import 'package:flutter/material.dart';
import 'package:hospital_management_app/routes/route_manager.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/utilities/validations.dart';
import 'package:hospital_management_app/view/widgets/buttons.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';
import 'package:hospital_management_app/view/widgets/password_form.dart';
import 'package:hospital_management_app/view/widgets/text_form.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:hospital_management_app/viewmodel/auth_viewmodels/login_viewmodel.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);
    return LoadingOverlay(
      isLoading: viewModel.loading,
      progressIndicator: circularProgress(context),
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
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
                const TitleText(text: 'Login'),
                const SizedBox(height: 50.0),
                buildForm(context, viewModel),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(RouteManager.registerPage),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'I am not registered.',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(RouteManager.adminRegisterPage),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Admin register.',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildForm(BuildContext context, LoginViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Icons.mail,
            hintText: "Enter your email",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel.setEmail(val);
            },
            focusNode: viewModel.emailFN,
            nextFocusNode: viewModel.passFN,
          ),
          const SizedBox(height: 15.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Icons.lock,
            suffix: Icons.remove_red_eye,
            hintText: "Enter your password",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validatePassword,
            submitAction: () => viewModel.login(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
            focusNode: viewModel.passFN,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(RouteManager.forgotPasswordPage),
                child: const SizedBox(
                  width: 130,
                  height: 40,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          LargeButton(
            label: 'Login',
            color: Theme.of(context).colorScheme.primary,
            onPressed: () => viewModel.login(context),
          ),
        ],
      ),
    );
  }
}
