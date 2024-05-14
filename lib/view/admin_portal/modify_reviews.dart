import 'package:flutter/material.dart';
import 'package:hospital_management_app/Model/review.dart';
import 'package:hospital_management_app/routes/route_manager.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/view/widgets/buttons.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';
import 'package:hospital_management_app/viewmodel/admin_viewmodels/mod_review.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class ModReviewsPage extends StatefulWidget {
  const ModReviewsPage({super.key, required this.arguments});
  final MyArguments arguments;

  @override
  State<ModReviewsPage> createState() => _ModReviewsPageState();
}

class _ModReviewsPageState extends State<ModReviewsPage> {
  @override
  Widget build(BuildContext context) {
    ModReviewsViewModel viewModel = Provider.of<ModReviewsViewModel>(context);
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
                const TitleText(text: 'Modify Review'),
                const SizedBox(height: 50.0),
                StreamBuilder(
                  stream: reviewsRef.doc(widget.arguments.uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: circularProgress(context),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.data() != null) {
                        ReviewModel reviewModel = ReviewModel.fromJson(
                            snapshot.data!.data() as Map<String, dynamic>);
                        return buildForm(context, viewModel, reviewModel);
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

  buildForm(BuildContext context, ModReviewsViewModel viewModel,
      ReviewModel reviewModel) {
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
            initialValue: reviewModel.hospitalName,
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
            onSaved: (val) {
              viewModel.setHospitalName(val);
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            enabled: !viewModel.loading,
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            initialValue: reviewModel.review,
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
            onSaved: (val) {
              viewModel.setReview(val);
            },
          ),
          const SizedBox(height: 25.0),
          LargeButton(
            label: 'Modify Review',
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              viewModel.modifyReview(context, widget.arguments.uid);
            },
          ),
          LargeButton(
            label: 'Delete Appointment',
            color: Theme.of(context).colorScheme.error,
            onPressed: () {
              viewModel.deleteReview(context, widget.arguments.uid);
            },
          ),
        ],
      ),
    );
  }
}
