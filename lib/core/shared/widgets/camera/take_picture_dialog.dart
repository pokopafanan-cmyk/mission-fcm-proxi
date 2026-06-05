import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../buttons/app_dialog_button.dart';
import '../common/show_app_dialog.dart';
import 'camera_view.dart';
import '../common/custom_dialog.dart';
import 'img_card.dart';

class IdentityDocumentPickerDialog extends StatefulWidget {

  final String title;

  const IdentityDocumentPickerDialog({
    super.key,
    required this.title,
  });

  @override
  State<IdentityDocumentPickerDialog> createState() => _IdentityDocumentPickerDialogState();
}

class _IdentityDocumentPickerDialogState extends State<IdentityDocumentPickerDialog> {

  late final ValueNotifier<XFile?> _imageNotifier = ValueNotifier(null);

  @override
  void dispose() {
    _imageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return CustomDialog(
      addDivider: false,
      titleMarginBottom: 0,
      title: widget.title,
      buttonMargin: false,
      children: [
        const SizedBox(height: 25),
        ValueListenableBuilder<XFile?>(
          valueListenable: _imageNotifier,
          builder: (context, image, child) {
            return image != null
                ? _buildImageView(image)
                : CameraView(
              isPhotoIdentity: true,
              onTakePicture: (file) => _imageNotifier.value = file,
            );
          },
        ),
        ValueListenableBuilder<XFile?>(
          valueListenable: _imageNotifier,
          builder: (context, image, child) {
            if (image == null) return const SizedBox(height: 15);

            return Column(
              children: [
                const SizedBox(height: 20),
                _buildActionButtons(),
                const SizedBox(height: 15),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildImageView(XFile image) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = (width * 56) / 86;

        return ImageView(
          width: width,
          height: height,
          xFile: image,
        );
      },
    );
  }

  Widget _buildActionButtons() {
    final screenWidth = MediaQuery.of(context).size.width;
    const buttonPadding = EdgeInsets.symmetric(horizontal: 14);
    final buttonWidth = screenWidth * 0.40;

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 12,
      children: [
        SizedBox(
          width: buttonWidth,
          child: Padding(
            padding: buttonPadding,
            child: AppDialogButton(
              enabled: true,
              text: "Changer",
              onTap: () => _imageNotifier.value = null,
            ),
          ),
        ),
        SizedBox(
          width: buttonWidth,
          child: Padding(
            padding: buttonPadding,
            child: AppDialogButton(
              enabled: true,
              text: "Garder",
              onTap: () {
                if (_imageNotifier.value != null) {
                  Navigator.of(context).pop(_imageNotifier.value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}


// Future<XFile?> showIdentityDocumentPickerDialog(BuildContext context, String title) async {
//   final xfile = await showDialog<XFile>(
//     context: context,
//     barrierDismissible: true,
//     barrierColor: Colors.black.withValues(alpha: 0.5),
//     builder: (BuildContext context) => TakePictureDialog(title: title,),
//   );
//   return xfile;
// }


Future<XFile?> showIdentityDocumentPickerDialog(BuildContext context, String title) async {
  final xfile = await showAppDialog<XFile>(
    context: context,
    barrierDismissible: true,
    canPop: true,
    child: IdentityDocumentPickerDialog(title: title,),
  );
  return xfile;
}



