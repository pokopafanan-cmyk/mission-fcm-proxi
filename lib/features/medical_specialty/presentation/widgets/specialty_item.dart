
import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';
import '../../data/models/medecin_specialty.dart';


class SpecialtyItem extends StatelessWidget {
  final MedicalSpecialty specialty;
  final VoidCallback onTap;
  final bool isSelected;

  const SpecialtyItem({
    super.key,
    required this.specialty,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected ? Color(specialty.color).withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: Color(specialty.color), width: 1.5) : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 52,
            width: 52,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(specialty.color).withOpacity(isSelected ? 1.0 : 0.75),
              borderRadius: BorderRadius.circular(12),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: Color(specialty.color).withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ] : [],
            ),
            child: Image.asset(
              specialty.iconPath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Center(
                child: AppText(
                  text: specialty.name[0],
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        SizedBox(height: 4,),
          AppText(
            text: specialty.name,
            fontSize: 11,
            color: isSelected ? AppColor.primaryColor : AppColor.blackColor,
            textAlign: TextAlign.center,
            maxLines: 2,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ],
      ),
    ),
      ),
    );
  }
}