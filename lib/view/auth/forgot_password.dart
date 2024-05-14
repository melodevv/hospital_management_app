import 'package:flutter/material.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/utilities/validations.dart';
import 'package:hospital_management_app/view/widgets/buttons.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';
import 'package:hospital_management_app/view/widgets/text_form.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:hospital_management_app/viewmodel/auth_viewmodels/forgot_pass_viewmodel.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    ForgotPassViewModel viewModel = Provider.of<ForgotPassViewModel>(context);
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
                const TitleText(text: 'Forgot Password'),
                const SizedBox(height: 50.0),
                buildForm(context, viewModel),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'I am ready to login.',
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

  buildForm(BuildContext context, ForgotPassViewModel viewModel) {
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
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel.setEmail(val);
            },
            focusNode: viewModel.emailFN,
          ),
          const SizedBox(height: 25.0),
          LargeButton(
            label: 'Reset Password',
            color: Theme.of(context).colorScheme.primary,
            onPressed: () => viewModel.forgotPassword(context),
          ),
        ],
      ),
    );
  }
}
