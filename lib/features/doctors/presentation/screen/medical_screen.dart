import 'package:flutter/material.dart';

import '../widgets/medical_data.dart';
import '../widgets/medical_header.dart';
import '../widgets/medical_item.dart';
import '../widgets/welcome_section.dart';


class MedicalScreen extends StatefulWidget {
  const MedicalScreen({super.key});

  @override
  State<MedicalScreen> createState() => _MedicalScreenState();
}

class _MedicalScreenState extends State<MedicalScreen> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MedicalHeader(),
              SizedBox(height: 25),
              WelcomeSection(name: "Zalissa"),
              const SizedBox(height: 35),
              _CategoryList(
                activeIndex: _activeIndex,
                onChanged: (index) => setState(() => _activeIndex = index),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _CategoryList extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onChanged;

  const _CategoryList({
    required this.activeIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: MedicalData.medicalCards.length,
      itemBuilder: (context, index) {
        final item = MedicalData.medicalCards[index];
        final bool isActive = index == activeIndex;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CardMedicalItem(
            medical: item,
            isActive: isActive,
            onTap: () => onChanged(index),
          ),
        );
      },
    );
  }
}
