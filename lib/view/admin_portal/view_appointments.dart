import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/Model/appointments.dart';
import 'package:hospital_management_app/routes/route_manager.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:intl/intl.dart';

class ViewAppointments extends StatefulWidget {
  const ViewAppointments({super.key});

  @override
  State<ViewAppointments> createState() => _ViewAppointmentsState();
}

class _ViewAppointmentsState extends State<ViewAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews List'),
      ),
      body: Padding(
        padding: appSidePadding,
        child: Column(
          children: [
            const SizedBox(height: 50.0),
            const TitleText(text: 'All Appointments'),
            const SizedBox(height: 30.0),
            StreamBuilder<QuerySnapshot>(
              stream: appointmentsRef.orderBy('dateTime').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        AppointmentModel appointmentModel =
                            AppointmentModel.fromJson(snapshot.data?.docs[index]
                                .data() as Map<String, dynamic>);

                        return Card(
                          color: Theme.of(context).colorScheme.secondary,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  RouteManager.modAppointmentsPage,
                                  arguments: MyArguments(
                                      snapshot.data!.docs[index].id));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('dd MMM yyyy   HH:mm').format(
                                        DateTime.parse(
                                            appointmentModel.dateTime!)),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    appointmentModel.reason!,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return circularProgress(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
