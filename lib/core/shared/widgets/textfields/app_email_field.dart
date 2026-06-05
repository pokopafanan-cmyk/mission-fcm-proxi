// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:string_validator/string_validator.dart';
// import '../../../theme/app_color.dart';
// import '../../../theme/app_theme.dart';
// import '../../../config/app_sizes.dart';
//
//
// class AppEmailField extends StatelessWidget {
//
//   final bool readOnly;
//   final String hintText;
//   final Color? fillColor;
//   final String? labelText;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final FocusNode? focusNode;
//   final VoidCallback? onTap;
//   final bool alignLabelWithHint;
//   final TextInputType? textInputType;
//   final ValueChanged<String>? onChanged;
//   final TextEditingController controller;
//   final TextInputAction? textInputAction;
//   final TextCapitalization textCapitalization;
//   final FloatingLabelBehavior? floatingLabelBehavior;
//   final List<TextInputFormatter> textInputFormatters;
//
//
//   const AppEmailField({
//     super.key,
//     this.fillColor,
//     this.labelText,
//     this.focusNode,
//     this.onChanged,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.readOnly = false,
//     required this.hintText,
//     required this.controller,
//     this.onTap,
//     this.floatingLabelBehavior = FloatingLabelBehavior.never,
//     this.alignLabelWithHint = false,
//     this.textInputType = TextInputType.text,
//     this.textInputAction = TextInputAction.next,
//     this.textCapitalization = TextCapitalization.sentences,
//     this.textInputFormatters = const <TextInputFormatter>[],
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<TextEditingValue>(
//       valueListenable: controller,
//       builder: (_, __, ___) {
//         final email = controller.text.trim();
//         final isValid = email.isNotEmpty && email.isEmail;
//         final Color dynamicColor = Theme.of(context).primaryColor.withValues(alpha: isValid ? 1.0 : 0.3);
//         final borderWidth = isValid ? 1.5 : 1.0;
//
//         return Container(
//           margin: EdgeInsets.only(bottom: AppSize.fieldMarginBottom),
//           child: TextFormField(
//             style: TextStyle(color: Colors.black, fontSize: AppSize.fieldFontSize,),
//             readOnly: readOnly,
//             focusNode: focusNode,
//             onChanged: onChanged,
//             controller: controller,
//             keyboardType: textInputType,
//             inputFormatters: textInputFormatters,
//             textCapitalization: textCapitalization,
//             cursorColor: Colors.black,
//             textInputAction: textInputAction,
//             onTap: onTap,
//
//             // Validation simple : renvoie une erreur si champ vide
//             validator: (value) => isValid ? null : '',
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: fillColor,
//               alignLabelWithHint: alignLabelWithHint,
//               hintText: hintText,
//               labelText: labelText,
//               suffixIcon: suffixIcon,
//               prefixIcon: prefixIcon,
//               floatingLabelBehavior: floatingLabelBehavior,
//
//               // Évite l'affichage trop visible de l'erreur
//               errorStyle: const TextStyle(height: 0.01,),
//
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
//
// }
//
//
//
//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_validator/string_validator.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../config/app_sizes.dart';

class AppEmailField extends StatelessWidget {
  final bool readOnly;
  final String hintText;
  final Color? fillColor;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool alignLabelWithHint;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter> textInputFormatters;

  const AppEmailField({
    super.key,
    this.fillColor,
    this.labelText,
    this.focusNode,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    required this.hintText,
    required this.controller,
    this.onTap,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.alignLabelWithHint = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputFormatters = const <TextInputFormatter>[],
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (_, __, ___) {
        final String email = controller.text.trim();
        final bool isValid = email.isNotEmpty && email.isEmail;

        final Color dynamicColor = Theme.of(context)
            .primaryColor
            .withValues(alpha: isValid ? 1.0 : 0.3);

        final double borderWidth = isValid ? 1.5 : 1.0;

        return Container(
          margin: EdgeInsets.only(
            bottom: AppSize.fieldMarginBottom,
          ),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            focusNode: focusNode,
            onChanged: onChanged,
            keyboardType: textInputType,
            inputFormatters: textInputFormatters,
            textCapitalization: textCapitalization,
            cursorColor: Colors.black,
            textInputAction: textInputAction,
            onTap: onTap,
            style: TextStyle(
              color: Colors.black,
              fontSize: AppSize.fieldFontSize,
            ),

            // validation simple
            validator: (_) => isValid ? null : '',

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white, // ✅ fond blanc

              alignLabelWithHint: alignLabelWithHint,
              hintText: hintText,
              labelText: labelText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              floatingLabelBehavior: floatingLabelBehavior,

              // cache le texte d’erreur
              errorStyle: const TextStyle(height: 0.01),

              // ✅ bordure grise quand email invalide
              enabledBorder: AppTheme.fieldBorder(
                color: isValid
                    ? dynamicColor
                    : AppColor.greyColor,
                width: borderWidth,
              ),

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
