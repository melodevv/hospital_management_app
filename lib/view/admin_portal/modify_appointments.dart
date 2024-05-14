import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:hospital_management_app/Model/appointments.dart';
import 'package:hospital_management_app/routes/route_manager.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/view/widgets/buttons.dart';
import 'package:hospital_management_app/view/widgets/date_time_text.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:hospital_management_app/viewmodel/admin_viewmodels/mod_appoint.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class ModAppointmentsPage extends StatefulWidget {
  const ModAppointmentsPage({super.key, required this.arguments});
  final MyArguments arguments;

  @override
  State<ModAppointmentsPage> createState() => _ModAppointmentsPageState();
}

class _ModAppointmentsPageState extends State<ModAppointmentsPage> {
  DateTime? _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    ModAppointmentViewModel viewModel =
        Provider.of<ModAppointmentViewModel>(context);
    return LoadingOverlay(
      isLoading: viewModel.loading,
      progressIndicator: circularProgress(context),
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
          title: const Text('Modify Appointments'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: appSidePadding,
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                const TitleText(text: 'Modify Appointment'),
                const SizedBox(height: 50.0),
                StreamBuilder(
                  stream: appointmentsRef.doc(widget.arguments.uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: circularProgress(context),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.data() != null) {
                        AppointmentModel appointmentModel =
                            AppointmentModel.fromJson(
                                snapshot.data!.data() as Map<String, dynamic>);
                        return buildForm(context, viewModel, appointmentModel);
                      }
                    }
                    return Container();
                  },
                ),
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

  buildForm(BuildContext context, ModAppointmentViewModel viewModel,
      AppointmentModel appointmentModel) {
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
                      : DateFormat('dd-MMM-yyyy')
                          .format(DateTime.parse(appointmentModel.dateTime!)),
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
                      : DateFormat('HH:mm')
                          .format(DateTime.parse(appointmentModel.dateTime!)),
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
            initialValue: appointmentModel.reason,
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
            onSaved: (val) {
              viewModel.setReason(val);
            },
          ),
          const SizedBox(height: 25.0),
          LargeButton(
            label: 'Update Appointment',
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              viewModel.setDateTime(_selectedDateTime.toString());
              viewModel.modifyAppointment(context, widget.arguments.uid);
            },
          ),
          LargeButton(
            label: 'Delete Appointment',
            color: Theme.of(context).colorScheme.error,
            onPressed: () {
              viewModel.deleteAppointment(context, widget.arguments.uid);
            },
          ),
        ],
      ),
    );
  }
}
