import 'package:flutter/material.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/utilities/validations.dart';
import 'package:hospital_management_app/view/widgets/buttons.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';
import 'package:hospital_management_app/view/widgets/password_form.dart';
import 'package:hospital_management_app/view/widgets/text_form.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:hospital_management_app/viewmodel/auth_viewmodels/register_viewmodel.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    RegisterViewModel viewModel = Provider.of<RegisterViewModel>(context);
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
                const TitleText(text: 'Register'),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1900),
      lastDate: DateTime(2005),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  buildForm(RegisterViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Icons.person,
            hintText: "First name",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateFName,
            onSaved: (String val) {
              viewModel.setFirstName(val);
            },
            focusNode: viewModel.fnameFN,
            nextFocusNode: viewModel.lnameFN,
          ),
          const SizedBox(height: 10.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Icons.person,
            hintText: "Last name",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateLName,
            onSaved: (String val) {
              viewModel.setLastName(val);
            },
            focusNode: viewModel.lnameFN,
            nextFocusNode: viewModel.dobFN,
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
                        : null,
                  ),
                  hintText: "Date of Birth",
                  textInputAction: TextInputAction.next,
                  validateFunction: Validations.validateDob,
                  onSaved: (String val) {
                    viewModel.setDob(val);
                  },
                  focusNode: viewModel.dobFN,
                  nextFocusNode: viewModel.idNrFN,
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
            enabled: !viewModel.loading,
            prefix: Icons.person,
            hintText: "ID Number",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateIdNr,
            onSaved: (String val) {
              viewModel.setId(val);
            },
            focusNode: viewModel.idNrFN,
            nextFocusNode: viewModel.contactNrFN,
          ),
          const SizedBox(height: 10.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Icons.person,
            hintText: "Contact Number",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validationContact,
            onSaved: (String val) {
              viewModel.setContactNr(val);
            },
            focusNode: viewModel.contactNrFN,
            nextFocusNode: viewModel.emailFN,
          ),
          const SizedBox(height: 10.0),
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
