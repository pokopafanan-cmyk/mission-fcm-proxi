import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../config/app_sizes.dart';

class AppPinField extends StatelessWidget {

  final int length;
  final bool obscureText;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final VoidCallback? onTap;

  const AppPinField({
    super.key,
    this.length = 4,
    this.obscureText = false,
    this.readOnly = false,
    this.onCompleted,
    this.onChanged,
    this.onTap,
    required this.controller,
    this.focusNode,
  }) : assert(length > 0, "length must be greater than 0");

  @override
  Widget build(BuildContext context) {

    // const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    // const fillColor = Color.fromRGBO(243, 246, 249, 0);
    // const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    const focusedBorderColor = Color(0xFF0973B6);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color(0x660973B6);

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Container(
      margin: EdgeInsets.only(bottom: AppSize.fieldMarginBottom),
      child: Pinput(
        controller: controller,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        length: length,
        obscureText: obscureText,
        readOnly: readOnly,

        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        hapticFeedbackType: HapticFeedbackType.lightImpact,

        // validator: (value) => value != null && value.isNotEmpty ? null : '',
        onCompleted: onCompleted,
        onChanged: onChanged,
        onTap: onTap,
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              width: 22,
              height: 1,
              color: focusedBorderColor,
            ),
          ],
        ),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: fillColor,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: Colors.redAccent),
        ),
      ),
    );
  }
}


