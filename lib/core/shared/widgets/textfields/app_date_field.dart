import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../config/app_sizes.dart';

class AppDateField extends StatelessWidget {

  final bool isSelected;
  final String hintText;
  final Color? fillColor;
  final String? labelText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool alignLabelWithHint;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final FloatingLabelBehavior? floatingLabelBehavior;

  AppDateField({
    super.key,
    this.fillColor,
    this.labelText,
    this.focusNode,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.firstDate,
    this.lastDate,
    required this.hintText,
    required this.controller,
    required this.isSelected,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.alignLabelWithHint = false,
  }) :

    assert(
      isSelected == false || firstDate != null,
      "firstDate must be provided when isSelected is true.",
    ),
    assert(
      isSelected == false || lastDate != null,
      "lastDate must be provided when isSelected is true.",
    ),
    assert(
      firstDate == null || lastDate == null || !lastDate.isBefore(firstDate),
      "lastDate must be after or equal to firstDate.",
    );


  final mask = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r"[0-9]")});

  bool _validateDate() {
    final input = controller.text.trim();

    if (input.isEmpty) return false;

    final RegExp dateRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$'); // (DD/MM/YYYY)
    if (!dateRegExp.hasMatch(input)) return false;

    // final [day, month, year] = input.split('/').map((e) => int.parse(e)).toList();

    // Séparer les parties de la date
    List<String> parts = input.split('/');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    // if (year < lastDate!.year || year > DateTime.now().year) return false;
    // if (year > DateTime.now().year) return false;

    // Vérifier si le jour est valide pour le mois donné
    try {
      DateTime date = DateTime(year, month, day);
      return date.day == day && date.month == month;
    } catch (_) {
      return false;
    }
  }

  Future<void> _selectDate(BuildContext context) async {

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate!,
      lastDate: lastDate!,
    );

    if (selectedDate != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (_, __, ___) {

        final isValid = _validateDate();
        final Color dynamicColor = Theme.of(context).primaryColor.withValues(alpha: isValid ? 1.0 : 0.3);
        final borderWidth = isValid ? 1.5 : 1.0;

        return Container(
          margin: EdgeInsets.only(bottom: AppSize.fieldMarginBottom),
          child: TextFormField(
            style: TextStyle(color: Colors.black, fontSize: AppSize.fieldFontSize,),
            readOnly: isSelected ? true : false,
            focusNode: focusNode,
            onChanged: onChanged,
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [mask],
            cursorColor: Colors.black,
            onTap: isSelected ? () => _selectDate(context) : null,
            // Validation simple : renvoie une erreur si champ vide
            validator: (value) => isValid ? null : '',
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor,
              alignLabelWithHint: alignLabelWithHint,
              hintText: hintText,
              labelText: labelText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              floatingLabelBehavior: floatingLabelBehavior,

              // Évite l'affichage trop visible de l'erreur
              errorStyle: const TextStyle(height: 0.01,),

              enabledBorder: AppTheme.fieldBorder(color: isValid ? dynamicColor : AppColor.transparentColor, width: borderWidth,),
              focusedBorder: AppTheme.fieldBorder(color: dynamicColor, width: 1.5,),
              focusedErrorBorder: AppTheme.fieldBorder(color: dynamicColor, width: 1.5,),
              errorBorder: AppTheme.fieldBorder(),
            ),
          ),
        );
      },
    );
  }
}






