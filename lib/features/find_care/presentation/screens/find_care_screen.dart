
import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/common/custom_app_bar.dart';
import '../../data/model/find_care_data.dart';
import '../widgets/find_list.dart';

class FindCareScreen extends StatelessWidget {
  const FindCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Soins fins'),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        itemCount: FindCareData.specialtie.length,
        itemBuilder: (context, index) {
          final doctor = FindCareData.specialtie[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FindCareList(care: doctor),
          );
        },
      ),
    );
  }
}