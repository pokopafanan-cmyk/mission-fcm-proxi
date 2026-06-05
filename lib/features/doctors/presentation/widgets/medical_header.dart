import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';
class MedicalHeader extends StatelessWidget {
  const MedicalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.sort, size: 28, color: AppColor.blackColor),
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: AppColor.blackColor,
            borderRadius: BorderRadius.circular(10),
            // image: const DecorationImage(
            //   image: AssetImage("assets/images/avatar.png"),
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
      ],
    );
  }
}