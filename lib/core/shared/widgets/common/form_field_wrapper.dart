import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';
import 'app_text.dart';

class FormFieldWrapper extends StatelessWidget {

  final String label;
  final Widget child;

  const FormFieldWrapper({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          color: AppColor.blackColor,
          fontWeight: FontWeight.w500,
        ),
        child,
      ],
    );
  }
}

