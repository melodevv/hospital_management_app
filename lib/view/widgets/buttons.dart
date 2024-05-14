import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.color,
  });
  final String label;
  final Function? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: MaterialButton(
        color: color,
        elevation: 6,
        height: 54,
        minWidth: 360,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            50.0,
          ),
        ),
        onPressed: onPressed as void Function()?,
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
