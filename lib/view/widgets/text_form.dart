// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class TextFormBuilder extends StatefulWidget {
  final String? initialValue;
  final bool? enabled;
  final bool? readOnly;
  final String? hintText;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final FocusNode? focusNode, nextFocusNode;
  final VoidCallback? submitAction;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved, onChange;
  final IconData? prefix;
  final IconData? suffix;

  const TextFormBuilder({
    super.key,
    this.prefix,
    this.suffix,
    this.initialValue,
    this.textCapitalization,
    this.enabled,
    this.readOnly,
    this.hintText,
    this.textInputType,
    this.controller,
    this.textInputAction,
    this.nextFocusNode,
    this.focusNode,
    this.submitAction,
    this.obscureText = false,
    this.validateFunction,
    this.onSaved,
    this.onChange,
  });

  @override
  _TextFormBuilderState createState() => _TextFormBuilderState();
}

class _TextFormBuilderState extends State<TextFormBuilder> {
  String? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            cursorColor: Theme.of(context).colorScheme.secondary,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            initialValue: widget.initialValue,
            enabled: widget.enabled,
            readOnly: widget.readOnly ?? false,
            onChanged: (val) {
              error = widget.validateFunction!(val);
              setState(() {});
              widget.onSaved!(val);
            },
            style: const TextStyle(
              fontSize: 15.0,
            ),
            key: widget.key,
            controller: widget.controller,
            obscureText: widget.obscureText,
            keyboardType: widget.textInputType,
            validator: widget.validateFunction,
            onSaved: (val) {
              error = widget.validateFunction!(val);
              setState(() {});
              widget.onSaved!(val!);
            },
            textInputAction: widget.textInputAction,
            focusNode: widget.focusNode,
            onFieldSubmitted: (String term) {
              if (widget.nextFocusNode != null) {
                widget.focusNode!.unfocus();
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              } else {
                widget.submitAction!();
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                widget.prefix,
                size: 16.0,
              ),
              hintText: widget.hintText,
              border: border(context),
              enabledBorder: border(context),
              focusedBorder: focusBorder(context),
              errorStyle: const TextStyle(height: 0.0, fontSize: 0.0),
            ),
          ),
          Visibility(
            visible: error != null,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                '$error',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  border(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.tertiary,
        width: 0.0,
      ),
      borderRadius: BorderRadius.circular(50.0),
    );
  }

  focusBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(50.0),
    );
  }
}
