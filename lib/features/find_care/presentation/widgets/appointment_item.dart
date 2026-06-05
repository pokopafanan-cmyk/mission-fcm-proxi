
import 'package:flutter/material.dart';
import 'package:proxi/features/find_care/presentation/widgets/section_row.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../data/model/section_model.dart';


class AppointmentItem extends StatelessWidget {
  final Appointment appointment;
  final bool isExpanded;
  final VoidCallback onToggle;

  const AppointmentItem({
    super.key,
    required this.appointment,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [

          ListTile(
            onTap: onToggle,
            leading: AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.keyboard_arrow_down, color: Colors.black87),
            ),
            title: AppText(
              text: appointment.title,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                children: appointment.content.map((data) => SectionRow(data.title, data.value)).toList(),
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}