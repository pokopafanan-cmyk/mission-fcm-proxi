import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';

class SectionRow extends StatelessWidget {
  final String title;
  final String value;

  const SectionRow(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: 130,
            child: AppText(
              text: "$title : ",
              color: AppColor.blackColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          Expanded(
            child: AppText(
              text: value,
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}