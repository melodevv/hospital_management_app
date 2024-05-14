// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class PasswordFormBuilder extends StatefulWidget {
  final String? initialValue;
  final bool? enabled;
  final String? hintText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode, nextFocusNode;
  final VoidCallback? submitAction;
  final bool obscureText;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved, onChange;
  final IconData? suffix;
  final IconData? prefix;

  const PasswordFormBuilder({
    super.key,
    this.prefix,
    this.suffix,
    this.initialValue,
    this.enabled,
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
  _PasswordFormBuilderState createState() => _PasswordFormBuilderState();
}

class _PasswordFormBuilderState extends State<PasswordFormBuilder> {
  String? error;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // cursorColor: Theme.of(context).colorScheme.secondary,
            initialValue: widget.initialValue,
            enabled: widget.enabled,
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
            // obscureText: widget.obscureText,
            obscureText: obscureText,
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
                // color: Theme.of(context).colorScheme.onBackground,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() => obscureText = !obscureText);
                },
                child: Icon(
                  obscureText ? widget.suffix : Icons.remove_red_eye,
                  size: 16.0,
                  // color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                  // color: Colors.grey[400],
                  ),
              border: border(context),
              enabledBorder: border(context),
              focusedBorder: focusBorder(context),
              errorStyle: const TextStyle(height: 0.0, fontSize: 0.0),
            ),
          ),
          const SizedBox(height: 5.0),
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
      borderSide: const BorderSide(
        // color: Theme.of(context).colorScheme.tertiary,
        width: 0.0,
      ),
      borderRadius: BorderRadius.circular(50.0),
    );
  }

  focusBorder(BuildContext context) {
    return UnderlineInputBorder(
      borderSide: const BorderSide(
        // color: Theme.of(context).colorScheme.secondary,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(50.0),
    );
  }
}
