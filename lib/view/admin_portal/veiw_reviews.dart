import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/Model/review.dart';
import 'package:hospital_management_app/routes/route_manager.dart';
import 'package:hospital_management_app/utilities/firebase.dart';
import 'package:hospital_management_app/utilities/utilities.dart';
import 'package:hospital_management_app/view/widgets/loading.dart';
import 'package:hospital_management_app/view/widgets/texts.dart';

class ViewReviews extends StatefulWidget {
  const ViewReviews({super.key});

  @override
  State<ViewReviews> createState() => _ViewReviewsState();
}

class _ViewReviewsState extends State<ViewReviews> {
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
            const TitleText(text: 'All Reviews'),
            const SizedBox(height: 30.0),
            StreamBuilder<QuerySnapshot>(
              stream: reviewsRef.orderBy('id').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        ReviewModel reviewModel = ReviewModel.fromJson(
                            snapshot.data?.docs[index].data()
                                as Map<String, dynamic>);

                        return Card(
                          color: Theme.of(context).colorScheme.secondary,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  RouteManager.modReviewPage,
                                  arguments: MyArguments(
                                      snapshot.data!.docs[index].id));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reviewModel.hospitalName!,
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
                                    reviewModel.review!,
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
