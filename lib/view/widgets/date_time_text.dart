// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DateTimeText extends StatelessWidget {
  DateTimeText({
    super.key,
    required this.text,
    required this.label,
    required this.enabled,
    this.initialValue,
  });
  String? text, label, initialValue;
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      readOnly: true,
      initialValue: initialValue,
      controller: TextEditingController(text: text),
      keyboardType: TextInputType.multiline,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 15.0,
      ),
      decoration: InputDecoration(
        labelText: label,
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
          return 'Select $label';
        }
        return null;
      },
    );
  }
}
