import 'dart:io';
import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';


class ImagePickerTile extends StatelessWidget {

  final VoidCallback onTap;
  final String? imagePath;
  final double size;

  const ImagePickerTile({
    super.key,
    required this.onTap,
    this.imagePath,
    this.size = 105,
  });

  bool get hasImage => imagePath != null && imagePath!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: size,
          height: size,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColor.secondaryColor,
            ),
            child: hasImage ? Image.file(File(imagePath!), fit: BoxFit.cover,)
              : Icon(
              Icons.camera_alt_outlined,
              size: size * 0.25,
              color: AppColor.blackColor.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}

