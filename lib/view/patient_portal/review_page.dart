import 'package:flutter/material.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/view/widgets/buttons.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:hospital_management_app/viewmodel/patient_viewmodels/review_viewmodel.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    ReviewsViewModel viewModel = Provider.of<ReviewsViewModel>(context);
    return LoadingOverlay(
      isLoading: viewModel.loading,
      progressIndicator: circularProgress(context),
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
          title: const Text('Review'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: appSidePadding,
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                const TitleText(text: 'Give A Review'),
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

  buildForm(BuildContext context, ReviewsViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            enabled: !viewModel.loading,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 15.0,
            ),
            decoration: InputDecoration(
              labelText: 'Hospital Name.',
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
                return 'Please enter the hospital you attended.';
              }
              return null;
            },
            onChanged: (val) {
              viewModel.setHospitalName(val);
            },
            onSaved: (val) {
              viewModel.setHospitalName(val);
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            enabled: !viewModel.loading,
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            style: const TextStyle(
              fontSize: 15.0,
            ),
            decoration: InputDecoration(
              hintText: 'Please enter a review on the hospital.',
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
                return 'Please enter a review.';
              }
              return null;
            },
            onChanged: (val) {
              viewModel.setReview(val);
            },
            onSaved: (val) {
              viewModel.setReview(val);
            },
          ),
          const SizedBox(height: 25.0),
          LargeButton(
            label: 'Set Appointment',
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              viewModel.submitReview(context);
            },
          ),
        ],
      ),
    );
  }
}
