import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';
import 'app_text.dart';

class DetailField extends StatelessWidget {

  final String label;
  final String value;

  const DetailField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          color: AppColor.blackColor,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 14,),
            child: AppText(
              text: value,
              color: AppColor.blackColor.withValues(alpha: 0.85),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
