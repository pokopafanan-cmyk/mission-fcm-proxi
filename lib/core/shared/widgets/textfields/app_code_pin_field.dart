import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "../../../config/app_constant.dart";
import "../../../config/app_sizes.dart";
import "../../../theme/app_color.dart";
import "../../../theme/app_theme.dart";

class AppCodePinField extends StatelessWidget {
  final String hintText;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final TextInputAction? textInputAction;

  const AppCodePinField({
    super.key,
    required this.hintText,
    this.textInputType = TextInputType.number,
    this.onChanged,
    required this.controller,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return _CodePinTextFieldBody(
      hintText: hintText,
      textInputType: textInputType,
      onChanged: onChanged,
      controller: controller,
      textInputAction: textInputAction,
    );
  }
}

class _CodePinTextFieldBody extends StatefulWidget {
  final String hintText;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final TextInputAction? textInputAction;

  const _CodePinTextFieldBody({
    required this.hintText,
    this.textInputType,
    this.onChanged,
    required this.controller,
    this.textInputAction,
  });

  @override
  State<_CodePinTextFieldBody> createState() =>
      _CodePinTextFieldBodyState();
}

class _CodePinTextFieldBodyState
    extends State<_CodePinTextFieldBody> {
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

        final double borderWidth =
        isValid ? 1.5 : 1.0;

        return Container(
          margin: EdgeInsets.only(
            bottom: AppSize.fieldMarginBottom,
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: obscureText,
            onChanged: widget.onChanged,
            keyboardType: widget.textInputType,
            inputFormatters: [
              AppConstant.codePinFormat,
            ],
            cursorColor: Colors.black,
            textInputAction: widget.textInputAction,
            style: TextStyle(
              color: Colors.black,
              fontSize: AppSize.fieldFontSize,
            ),
            validator: (_) => isValid ? null : '',
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hintText,
              errorStyle:
              const TextStyle(height: 0.01),
              enabledBorder: AppTheme.fieldBorder(color: isValid ? dynamicColor : AppColor.greyColor, width: borderWidth,),
              focusedBorder: AppTheme.fieldBorder(color: dynamicColor, width: 1.5,),
              focusedErrorBorder:
              AppTheme.fieldBorder(color: dynamicColor, width: 1.5,),
              errorBorder: AppTheme.fieldBorder(color: AppColor.greyColor, width: 1.0,),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: AppColor.primaryColor,
                ),
                onPressed: () => setState(
                        () => obscureText = !obscureText),
              ),
            ),
          ),
        );
      },
    );
  }
}
