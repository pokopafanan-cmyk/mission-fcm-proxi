import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../config/app_sizes.dart';
import '../common/app_text.dart';

class AppDropdownField extends StatefulWidget {

  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final List<String> data;
  final ValueChanged<String?> onChanged;

  const AppDropdownField({
    super.key,
    this.hintText,
    required this.data,
    required this.onChanged,
    this.initialValue,
    this.labelText
  });

  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {

  // Notifie si le champ est rempli ou non
  late final ValueNotifier<bool> isFilled;

  @override
  void initState() {
    super.initState();

    // initialValue => bordure pleine si déjà sélectionné
    isFilled = ValueNotifier(widget.initialValue != null);
  }


  @override
  void dispose() {
    isFilled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isFilled,
        builder: (context, filled, _) {

          final opacity = filled ? 1.0 : 0.3;
          final Color dynamicColor = Theme.of(context).primaryColor.withValues(alpha: opacity);
          final borderWidth = filled ? 1.5 : 1.0;

        return Container(
          margin: EdgeInsets.only(bottom: AppSize.fieldMarginBottom),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: DropdownButtonFormField(
                style: TextStyle(color: Colors.black, fontSize: AppSize.fieldFontSize,),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  constraints: BoxConstraints(),
                  errorStyle: const TextStyle(height: 0.01,),
                  enabledBorder: AppTheme.fieldBorder(color: filled ? dynamicColor : AppColor.transparentColor, width: borderWidth),
                  focusedBorder: AppTheme.fieldBorder(color: dynamicColor, width: 1.5,),
                  focusedErrorBorder: AppTheme.fieldBorder(color: dynamicColor, width: 1.5,),
                  errorBorder: AppTheme.fieldBorder(),
                ),
                isExpanded: true,
                isDense: true,
                initialValue: widget.initialValue,
                selectedItemBuilder: (BuildContext context) {
                  return widget.data.map<Widget>((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: AppText(text: item, color: Colors.black,),
                    );
                  }).toList();
                },
                dropdownColor: Colors.white,
                items: widget.data.map((item) {
                  if (item == widget.initialValue) {
                    return DropdownMenuItem(
                      value: item,
                      child: AppText(
                        text: item,
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return DropdownMenuItem(
                      value: item,
                      child: AppText(text: item),
                    );
                  }
                }).toList(),
                onChanged: (String? value) {
                  widget.onChanged(value);
                  // Bascule l'opacité selon sélection
                  isFilled.value = value != null;
                },
              ),
            ),
          ),
        );
      }
    );
  }
}