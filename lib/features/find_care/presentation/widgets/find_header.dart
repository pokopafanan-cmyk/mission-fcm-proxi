

import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../generated/assets.dart';

class FindHeader extends StatelessWidget {
  const FindHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(5),
              image:  DecorationImage(
                image: AssetImage(Assets.images.doctor4.path),
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  text: "Dr. Abraham Pigeon",
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),

                const SizedBox(height: 12),

                _rowInfo("Email :", "Abdui0101@gmail.com"),
                const SizedBox(height: 6),
                _rowInfo("Phone :", "225 074962-6642"),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _rowInfo(String label, String value) {
    return Row(
      children: [

        AppText(
          text: label,
          color: AppColor.blackColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),

        const SizedBox(width: 5),

        Expanded(
          child: AppText(
            text: value,
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}