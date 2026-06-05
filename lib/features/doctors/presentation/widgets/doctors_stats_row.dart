import 'package:flutter/material.dart';

import '../../../../core/shared/extensions/extensions.dart';
import '../../../../core/shared/widgets/common/app_text.dart';


class DoctorStatsRow extends StatelessWidget {
  final double rating;
  const DoctorStatsRow({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _stat("Experience", "3 Years"),
        _divider(),
        _stat("Patients", "122+"),
        _divider(),
        _stat("Rating", rating.toString()),
      ],
    );
  }

  Widget _stat(String label, String value) {
    return Column(
      children: [
        AppText(text: value, fontWeight: FontWeight.bold, fontSize: 16),
        SizedBox(height: 4,),
        AppText(text: label, fontSize: 12, color: Colors.grey),
      ],
    );
  }

  Widget _divider() => Container(height: 30, width: 1, color: Colors.grey[300]);
}