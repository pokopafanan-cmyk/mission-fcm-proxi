import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';
import 'app_text.dart';

class ItemsSummaryBar extends StatelessWidget {

  final double? weight;
  final int? total;
  final IconData icon;
  final VoidCallback onTap;

  const ItemsSummaryBar({
    super.key,
    this.weight,
    this.total,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      width: double.infinity,
      height: 70,
      child: Row(
        children: [
          if (weight != null)
            AppText(
              text: "Poids: ${weight!.toStringAsFixed(0)} Kg",
              color: AppColor.blackColor,
            ),

          Expanded(
            child: Center(
              child: total != null
                ? AppText(
                text: "Total: $total",
                color: AppColor.blackColor,
              )
                : const SizedBox.shrink(),
            ),
          ),

          GestureDetector(
            onTap: onTap,
            child: _ActionIcon(icon: icon),
          ),
        ],
      ),
    );
  }
}


class _ActionIcon extends StatelessWidget {

  final IconData icon;

  const _ActionIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon, size: 25, color: AppColor.whiteColor),
    );
  }
}



