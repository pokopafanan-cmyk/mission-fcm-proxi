
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import '../camera/take_picture_dialog.dart';
import 'app_textfield.dart';

class AppIdentityDocumentPicker extends StatelessWidget {

  final String hintText;
  final String dialogTitle;
  final String? labelText;
  final TextEditingController controller;
  final ValueChanged<XFile?> fileChanged;

  const AppIdentityDocumentPicker({
    super.key,
    required this.hintText,
    required this.dialogTitle,
    required this.fileChanged,
    required this.controller,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      readOnly: true,
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      onTap: () async {
        final xfile = await showIdentityDocumentPickerDialog(context, dialogTitle);
        if (xfile == null) return;
        controller.text = xfile.name;
        fileChanged(xfile);
      },
    );
  }

}

