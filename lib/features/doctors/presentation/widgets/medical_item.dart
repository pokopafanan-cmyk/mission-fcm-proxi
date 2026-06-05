import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';
import '../../data/model/medical_card.dart';

class CardMedicalItem extends StatelessWidget {
  final MedicalCard medical;
  final VoidCallback onTap;
  final bool isActive;

  const CardMedicalItem({
    super.key,
    required this.medical,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isActive ? AppColor.primaryColor : Colors.green[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Image.asset(
                medical.imgPath,
                height: 45,
                color: isActive ? Colors.white : AppColor.primaryColor,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: AppText(
                  text: medical.name,
                  color: isActive ? Colors.white : AppColor.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}