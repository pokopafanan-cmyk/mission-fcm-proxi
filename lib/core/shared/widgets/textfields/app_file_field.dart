import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../config/app_sizes.dart';

class AppFileField extends StatelessWidget {

  final String hintText;
  final Color? fillColor;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool alignLabelWithHint;
  final List<String>? allowedExtensions;
  final ValueChanged<String>? onChanged;
  final ValueChanged<XFile?> fileChanged;
  final TextEditingController controller;
  final FloatingLabelBehavior? floatingLabelBehavior;


  const AppFileField({
    super.key,
    this.fillColor,
    this.labelText,
    this.focusNode,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    required this.hintText,
    this.allowedExtensions,
    required this.controller,
    required this.fileChanged,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.alignLabelWithHint = false
  });



  Future<XFile?> _pickFile() async {

    final type = allowedExtensions != null && allowedExtensions!.isNotEmpty ? FileType.custom : FileType.any;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
    );

    if (result != null && result.files.single.path != null) {

      final path = result.files.single.path;
      final xfile = XFile(path!);
      controller.text = result.files.single.name;

      return xfile;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (_, __, ___) {

        final isValid = controller.text.trim().isNotEmpty;
        final Color dynamicColor  = Theme.of(context).primaryColor.withValues(alpha: isValid ? 1.0 : 0.3);
        final borderWidth = isValid ? 1.5 : 1.0;

        return Container(
          margin: EdgeInsets.only(bottom: AppSize.fieldMarginBottom),
          child: TextFormField(
            style: TextStyle(color: Colors.black, fontSize: AppSize.fieldFontSize,),
            readOnly: true,
            focusNode: focusNode,
            onChanged: onChanged,
            controller: controller,
            cursorColor: Colors.black,
            onTap: () async {
              final xfile = await _pickFile();
              if (xfile == null) return;
              fileChanged(xfile);
            },

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



