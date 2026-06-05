import 'package:flutter/material.dart';
import '../widgets/specialty_data.dart';
import '../widgets/specialty_item.dart';

class SpecialtyGridSection extends StatefulWidget {
  const SpecialtyGridSection({super.key});

  @override
  State<SpecialtyGridSection> createState() => _SpecialtyGridSectionState();
}

class _SpecialtyGridSectionState extends State<SpecialtyGridSection> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final specialty = SpecialtyData.specialties[index];

            return SpecialtyItem(
              specialty: specialty,
              isSelected: selectedIndex == index,
              onTap: () {
                setState(() {
                  selectedIndex =
                  (selectedIndex == index) ? null : index;
                });
              },
            );
          },
          childCount: SpecialtyData.specialties.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 3,
          crossAxisSpacing: 5,
          childAspectRatio: 0.90,
        ),
      ),
    );
  }
}