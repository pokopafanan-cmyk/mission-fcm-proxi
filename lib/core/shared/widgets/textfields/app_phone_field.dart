// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../../theme/app_color.dart';
// import '../../../theme/app_theme.dart';
// import '../../../config/app_sizes.dart';
// import '../common/app_text.dart';
//
// class AppPhoneField extends StatelessWidget {
//
//   static const allowedMobileMoney = {"om", "momo", "moov", "tresor", "wave"};
//
//   final bool readOnly;
//   final String hintText;
//   final String countryCode;
//   final String? mobileMoney;
//   final Color? fillColor;
//   final String? labelText;
//   // final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final FocusNode? focusNode;
//   final VoidCallback? onTap;
//   final bool alignLabelWithHint;
//   final ValueChanged<String>? onChanged;
//   final TextEditingController controller;
//   final TextInputAction? textInputAction;
//   final FloatingLabelBehavior? floatingLabelBehavior;
//   final List<TextInputFormatter> textInputFormatters;
//
//   AppPhoneField({
//     super.key,
//     this.fillColor,
//     this.labelText,
//     this.focusNode,
//     this.onChanged,
//     this.suffixIcon,
//     // this.prefixIcon,
//     this.readOnly = false,
//     required this.hintText,
//     this.countryCode = "+225",
//     this.mobileMoney,
//     required this.controller,
//     this.floatingLabelBehavior = FloatingLabelBehavior.never,
//     this.alignLabelWithHint = false,
//     this.onTap,
//     this.textInputAction = TextInputAction.next,
//     this.textInputFormatters = const <TextInputFormatter>[],
//   }) :
//
//     // mobileMoney must be valid
//     assert(
//     mobileMoney == null || allowedMobileMoney.contains(mobileMoney),
//     "mobileMoney must be one of: om, momo, moov, tresor, wave",
//     ),
//
//     // countryCode must start with +
//     assert(
//     countryCode.startsWith("+"),
//     "countryCode must start with '+'. Example: '+225'",
//     ),
//
//     // countryCode digits validation
//     assert(
//     RegExp(r'^\+\d+$').hasMatch(countryCode),
//     "countryCode must contain only digits after '+'. Example: '+225'",
//     );
//
//
//
//   bool _validatePhoneNumber() {
//
//     final number = controller.text.trim().replaceAll(" ", "");
//     final length = number.length;
//     final code = countryCode.replaceAll("+", "");
//
//     // CI
//     if (code == "225") {
//       const mmRules = {
//         "om":   ["07"],
//         "momo": ["05"],
//         "moov": ["01"],
//         "tresor": ["01", "05", "07"],
//         "wave":  ["01", "05", "07"],
//       };
//
//       if (mobileMoney == null) {
//         return length == 10 && (number.startsWith("01") || number.startsWith("05") || number.startsWith("07"));
//       }
//
//       final allowedPrefixes = mmRules[mobileMoney];
//       return allowedPrefixes != null && length == 10 && allowedPrefixes.any(number.startsWith);
//     }
//
//     // MALI/BURKINA/TOGO/BENIN
//     const eightDigitCountries = {"223", "226", "228", "229"}; // Set<String>
//     if (eightDigitCountries.contains(code)) {
//       return length == 8;
//     }
//
//     // GUINÉE
//     if (code == "224") {
//       return length == 8 || length == 9;
//     }
//
//     return false;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<TextEditingValue>(
//       valueListenable: controller,
//       builder: (_, __, ___) {
//
//         final isValid = _validatePhoneNumber();
//         final dynamicColor = Theme.of(context).primaryColor.withValues(alpha: isValid ? 1 : 0.3);
//         final borderWidth = isValid ? 1.5 : 1.0;
//
//         return Container(
//           margin: EdgeInsets.only(bottom: AppSize.fieldMarginBottom),
//           child: TextFormField(
//             controller: controller,
//             onChanged: onChanged,
//             readOnly: readOnly,
//             focusNode: focusNode,
//             keyboardType: TextInputType.phone,
//             inputFormatters: textInputFormatters,
//             cursorColor: Colors.black,
//             textInputAction: textInputAction,
//             style: TextStyle(color: Colors.black, fontSize: AppSize.fieldFontSize,),
//
//             validator: (_) => isValid ? null : '',
//             onTap: onTap,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: fillColor,
//               hintText: hintText,
//               labelText: labelText,
//               // prefixIcon: prefixIcon,
//               suffixIcon: suffixIcon,
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.only(right: 6, left: 12),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.call),
//                     SizedBox(width: 5,),
//                     AppText(
//                       text: countryCode,
//                       color: Colors.black,
//                     ),
//                   ],
//                 ),
//               ),
//               floatingLabelBehavior: floatingLabelBehavior,
//               alignLabelWithHint: alignLabelWithHint,
//               errorStyle: const TextStyle(height: 0.01),
//               enabledBorder: AppTheme.fieldBorder(color: isValid ? dynamicColor : AppColor.transparentColor, width: borderWidth,),
//               focusedBorder: AppTheme.fieldBorder(color: dynamicColor, width: 1.5,),
//               focusedErrorBorder: AppTheme.fieldBorder(color: dynamicColor, width: 1.5,),
//               errorBorder: AppTheme.fieldBorder(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
//
//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../config/app_sizes.dart';
import '../common/app_text.dart';

class AppPhoneField extends StatelessWidget {
  static const allowedMobileMoney = {
    "om",
    "momo",
    "moov",
    "tresor",
    "wave"
  };

  final bool readOnly;
  final String hintText;
  final String countryCode;
  final String? mobileMoney;
  final Color? fillColor;
  final String? labelText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool alignLabelWithHint;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter> textInputFormatters;

  AppPhoneField({
    super.key,
    this.fillColor,
    this.labelText,
    this.focusNode,
    this.onChanged,
    this.suffixIcon,
    this.readOnly = false,
    required this.hintText,
    this.countryCode = "+225",
    this.mobileMoney,
    required this.controller,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.alignLabelWithHint = false,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.textInputFormatters = const <TextInputFormatter>[],
  })  : assert(
  mobileMoney == null ||
      allowedMobileMoney.contains(mobileMoney),
  "mobileMoney must be one of: om, momo, moov, tresor, wave",
  ),
        assert(
        countryCode.startsWith("+"),
        "countryCode must start with '+'. Example: '+225'",
        ),
        assert(
        RegExp(r'^\+\d+$').hasMatch(countryCode),
        "countryCode must contain only digits after '+'. Example: '+225'",
        );

  bool _validatePhoneNumber() {
    final number =
    controller.text.trim().replaceAll(" ", "");
    final length = number.length;
    final code = countryCode.replaceAll("+", "");

    // CÔTE D’IVOIRE
    if (code == "225") {
      const mmRules = {
        "om": ["07"],
        "momo": ["05"],
        "moov": ["01"],
        "tresor": ["01", "05", "07"],
        "wave": ["01", "05", "07"],
      };

      if (mobileMoney == null) {
        return length == 10 &&
            (number.startsWith("01") ||
                number.startsWith("05") ||
                number.startsWith("07"));
      }

      final allowedPrefixes = mmRules[mobileMoney];
      return allowedPrefixes != null &&
          length == 10 &&
          allowedPrefixes.any(number.startsWith);
    }

    // MALI / BURKINA / TOGO / BENIN
    const eightDigitCountries = {
      "223",
      "226",
      "228",
      "229"
    };
    if (eightDigitCountries.contains(code)) {
      return length == 8;
    }

    // GUINÉE
    if (code == "224") {
      return length == 8 || length == 9;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (_, __, ___) {
        final bool isValid = _validatePhoneNumber();

        final Color dynamicColor = Theme.of(context)
            .primaryColor
            .withValues(alpha: isValid ? 1.0 : 0.3);

        final double borderWidth =
        isValid ? 1.5 : 1.0;

        return Container(
          margin: EdgeInsets.only(
            bottom: AppSize.fieldMarginBottom,
          ),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            readOnly: readOnly,
            focusNode: focusNode,
            keyboardType: TextInputType.phone,
            inputFormatters: textInputFormatters,
            cursorColor: Colors.black,
            textInputAction: textInputAction,
            onTap: onTap,
            style: TextStyle(
              color: Colors.black,
              fontSize: AppSize.fieldFontSize,
            ),

            validator: (_) => isValid ? null : '',

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white, // ✅ fond blanc

              hintText: hintText,
              labelText: labelText,
              suffixIcon: suffixIcon,

              prefixIcon: Padding(
                padding:
                const EdgeInsets.only(left: 12, right: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.call),
                    const SizedBox(width: 5),
                    AppText(
                      text: countryCode,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),

              floatingLabelBehavior:
              floatingLabelBehavior,
              alignLabelWithHint: alignLabelWithHint,

              errorStyle:
              const TextStyle(height: 0.01),

              // ✅ bordure grise quand invalide
              enabledBorder: AppTheme.fieldBorder(color: isValid ? dynamicColor : AppColor.greyColor, width: borderWidth,),
              focusedBorder: AppTheme.fieldBorder(color: dynamicColor, width: 1.5,),
              focusedErrorBorder: AppTheme.fieldBorder(color: dynamicColor, width: 1.5,),
              errorBorder: AppTheme.fieldBorder(color: AppColor.greyColor, width: 1.0,),
            ),
          ),
        );
      },
    );
  }
}
