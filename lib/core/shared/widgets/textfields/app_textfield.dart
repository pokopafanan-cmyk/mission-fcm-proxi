// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../../config/app_sizes.dart';
// import '../../../theme/app_color.dart';
// import '../../../theme/app_theme.dart';
//
//
// class AppTextField extends StatelessWidget {
//
//   final bool readOnly;
//   final int? maxLines;
//   final String? hintText;
//   final Color? fillColor;
//   final String? labelText;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final FocusNode? focusNode;
//   final double? marginBottom;
//   final bool alignLabelWithHint;
//   final TextInputType? textInputType;
//   final ValueChanged<String>? onChanged;
//   final TextEditingController controller;
//   final TextInputAction? textInputAction;
//   final TextCapitalization textCapitalization;
//   final VoidCallback? onTap;
//   // final FormFieldValidator<String>? validator;
//   final FloatingLabelBehavior? floatingLabelBehavior;
//   final List<TextInputFormatter> textInputFormatters;
//
//
//   const AppTextField({
//     super.key,
//     this.maxLines,
//     this.fillColor,
//     this.labelText,
//     this.focusNode,
//     // this.validator,
//     this.onChanged,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.readOnly = false,
//     this.hintText,
//     required this.controller,
//     this.floatingLabelBehavior = FloatingLabelBehavior.never,
//     this.alignLabelWithHint = false,
//     this.onTap,
//     this.marginBottom,
//     this.textInputType = TextInputType.text,
//     this.textInputAction = TextInputAction.next,
//     this.textCapitalization = TextCapitalization.sentences,
//     this.textInputFormatters = const <TextInputFormatter>[],
//   });
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<TextEditingValue>(
//       valueListenable: controller,
//       builder: (_, _, _) {
//
//         final isValid = controller.text.trim().isNotEmpty;
//         final Color dynamicColor = Theme.of(context).primaryColor.withValues(alpha: isValid ? 1.0 : 0.3);
//         final borderWidth = isValid ? 1.5 : 1.0;
//
//         return Container(
//           margin: EdgeInsets.only(bottom: marginBottom ?? AppSize.fieldMarginBottom),
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
//             maxLines: maxLines,
//             onTap: onTap,
//             textInputAction: textInputAction,
//             // Validation simple : renvoie une erreur si champ vide
//             validator: (value) => isValid ? null : '',
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: AppColor.blackColor,
//               alignLabelWithHint: alignLabelWithHint,
//               hintText: hintText,
//               labelText: labelText,
//               suffixIcon: suffixIcon,
//               prefixIcon: prefixIcon,
//               floatingLabelBehavior: floatingLabelBehavior,
//
//               // Évite l'affichage trop visible de l'erreur
//               errorStyle: const TextStyle(height: 0.01,),
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/app_sizes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final bool readOnly;
  final int? maxLines;
  final String? hintText;
  final Color? fillColor;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final double? marginBottom;
  final bool alignLabelWithHint;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final VoidCallback? onTap;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter> textInputFormatters;

  const AppTextField({
    super.key,
    this.maxLines,
    this.fillColor,
    this.labelText,
    this.focusNode,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.hintText,
    required this.controller,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.alignLabelWithHint = false,
    this.onTap,
    this.marginBottom,
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
        final bool isValid = controller.text.trim().isNotEmpty;

        final Color dynamicColor = Theme.of(context)
            .primaryColor
            .withValues(alpha: isValid ? 1.0 : 0.3);

        final double borderWidth = isValid ? 1.5 : 1.0;

        return Container(
          margin: EdgeInsets.only(
            bottom: marginBottom ?? AppSize.fieldMarginBottom,
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
            maxLines: maxLines,
            onTap: onTap,
            textInputAction: textInputAction,
            style: TextStyle(
              color: Colors.black,
              fontSize: AppSize.fieldFontSize,
            ),

            // validation simple (champ vide)
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

              // ✅ bordure grise par défaut
              enabledBorder: AppTheme.fieldBorder(
                color: isValid ? dynamicColor : AppColor.greyColor,
                width: borderWidth,
              ),

              focusedBorder: AppTheme.fieldBorder(
                color: dynamicColor,
                width: 1.5,
              ),

              focusedErrorBorder: AppTheme.fieldBorder(
                color: dynamicColor,
                width: 1.5,
              ),

              errorBorder: AppTheme.fieldBorder(
                color: AppColor.greyColor,
                width: 1.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
