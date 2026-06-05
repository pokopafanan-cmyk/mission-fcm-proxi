// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../../config/app_sizes.dart';
// import '../../../theme/app_color.dart';
// import '../../../theme/app_theme.dart';
//
// class AppPasswordField extends StatefulWidget {
//
//   final bool readOnly;
//   final int? maxLines;
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
//   // final FormFieldValidator<String>? validator;
//   final FloatingLabelBehavior? floatingLabelBehavior;
//   final List<TextInputFormatter> textInputFormatters;
//
//   const AppPasswordField({
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
//   State<AppPasswordField> createState() => _AppPasswordFieldState();
// }
//
// class _AppPasswordFieldState extends State<AppPasswordField> {
//
//   bool obscureText = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<TextEditingValue>(
//       valueListenable: widget.controller,
//       builder: (_, __, ___) {
//
//         final isValid = widget.controller.text.trim().isNotEmpty;
//         final Color dynamicColor = Theme.of(context).primaryColor.withValues(alpha: isValid ? 1.0 : 0.3);
//         final double borderWidth = isValid ? 1.5 : 1.0;
//
//         return Container(
//           margin: EdgeInsets.only(bottom: AppSize.fieldMarginBottom),
//           child: TextFormField(
//             style: TextStyle(color: Colors.black, fontSize: AppSize.fieldFontSize,),
//             readOnly: widget.readOnly,
//             focusNode: widget.focusNode,
//             onChanged: widget.onChanged,
//             controller: widget.controller,
//             keyboardType: widget.textInputType,
//             inputFormatters: widget.textInputFormatters,
//             textCapitalization: widget.textCapitalization,
//             cursorColor: Colors.black,
//             obscureText: obscureText,
//             textInputAction: widget.textInputAction,
//             onTap: widget.onTap,
//
//             // Validation simple : renvoie une erreur si champ vide
//             validator: (value) => isValid ? null : '',
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: widget.fillColor,
//               alignLabelWithHint: widget.alignLabelWithHint,
//               hintText: widget.hintText,
//               labelText: widget.labelText,
//               // Toggle visibility button
//               suffixIcon: IconButton(
//                 icon: Icon(
//                   obscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded,
//                   color: AppColor.primaryColor,
//                 ),
//                 onPressed: () => setState(() => obscureText = !obscureText),
//               ),
//               prefixIcon: widget.prefixIcon,
//               floatingLabelBehavior: widget.floatingLabelBehavior,
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
// }
//
//
//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/app_sizes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';

class AppPasswordField extends StatefulWidget {
  final bool readOnly;
  final int? maxLines;
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

  const AppPasswordField({
    super.key,
    this.maxLines,
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
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: widget.controller,
      builder: (_, __, ___) {
        final bool isValid =
            widget.controller.text.trim().isNotEmpty;

        final Color dynamicColor = Theme.of(context)
            .primaryColor
            .withValues(alpha: isValid ? 1.0 : 0.3);

        final double borderWidth = isValid ? 1.5 : 1.0;

        return Container(
          margin: EdgeInsets.only(
            bottom: AppSize.fieldMarginBottom,
          ),
          child: TextFormField(
            controller: widget.controller,
            readOnly: widget.readOnly,
            focusNode: widget.focusNode,
            onChanged: widget.onChanged,
            keyboardType: widget.textInputType,
            inputFormatters: widget.textInputFormatters,
            textCapitalization: widget.textCapitalization,
            cursorColor: Colors.black,
            obscureText: obscureText,
            textInputAction: widget.textInputAction,
            onTap: widget.onTap,
            style: TextStyle(
              color: Colors.black,
              fontSize: AppSize.fieldFontSize,
            ),

            // validation simple
            validator: (_) => isValid ? null : '',

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white, // ✅ fond blanc

              alignLabelWithHint: widget.alignLabelWithHint,
              hintText: widget.hintText,
              labelText: widget.labelText,
              prefixIcon: widget.prefixIcon,
              floatingLabelBehavior:
              widget.floatingLabelBehavior,

              // bouton afficher / masquer le mot de passe
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: AppColor.primaryColor,
                ),
                onPressed: () =>
                    setState(() => obscureText = !obscureText),
              ),

              // cache l’erreur
              errorStyle: const TextStyle(height: 0.01),

              // ✅ bordure grise par défaut
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
