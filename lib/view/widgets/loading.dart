import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Center circularProgress(context) {
  return Center(
    child: SpinKitThreeBounce(
      size: 40.0,
      color: Theme.of(context).colorScheme.secondary,
    ),
  );
}
