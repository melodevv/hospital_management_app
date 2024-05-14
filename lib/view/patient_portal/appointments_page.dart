import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/view/widgets/buttons.dart';
import 'package:hospital_management_app/view/widgets/date_time_text.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:hospital_management_app/viewmodel/patient_viewmodels/appointments_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  DateTime? _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    AppointmentsViewModel viewModel =
        Provider.of<AppointmentsViewModel>(context);
    return LoadingOverlay(
      isLoading: viewModel.loading,
      progressIndicator: circularProgress(context),
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
          title: const Text('Appointments'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: appSidePadding,
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                const TitleText(text: 'Make an Appointment'),
                const SizedBox(height: 50.0),
                buildForm(context, viewModel),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dateTimePickerWidget(BuildContext context) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: _selectedDateTime ?? DateTime.now(),
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _selectedDateTime = dateTime;
        });
      },
    );
  }

  buildForm(BuildContext context, AppointmentsViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: DateTimeText(
                  label: 'Date',
                  text: _selectedDateTime != null
                      ? DateFormat('dd-MMM-yyyy').format(_selectedDateTime!)
                      : null,
                  enabled: !viewModel.loading,
                ),
              ),
              const SizedBox(width: 5.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: DateTimeText(
                  label: 'Time',
                  text: _selectedDateTime != null
                      ? DateFormat('HH:mm').format(_selectedDateTime!)
                      : null,
                  enabled: !viewModel.loading,
                ),
              ),
              const SizedBox(width: 10.0),
              MaterialButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  dateTimePickerWidget(context);
                },
                minWidth: 10,
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 15.0),
                child: const Text(
                  'Date',
                ),
              ),
            ],
          ),
          const SizedBox(height: 25.0),
          TextFormField(
            enabled: !viewModel.loading,
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            style: const TextStyle(
              fontSize: 15.0,
            ),
            decoration: InputDecoration(
              hintText: 'Reason for Appointment',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                  width: 0.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                  width: 0.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a reason for your appointment.';
              }
              return null;
            },
            onChanged: (val) {
              viewModel.setReason(val);
            },
            onSaved: (val) {
              viewModel.setReason(val);
            },
          ),
          const SizedBox(height: 25.0),
          LargeButton(
            label: 'Set Appointment',
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              viewModel.setDateTime(_selectedDateTime.toString());
              viewModel.setAppointment(context);
            },
          ),
        ],
      ),
    );
  }
}
