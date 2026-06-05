import 'package:flutter/material.dart';

import '../../../../core/shared/extensions/extensions.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';

class DoctorActionBottomBar extends StatelessWidget {

  const DoctorActionBottomBar({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        children: [
          _chatButton(),
          SizedBox(width: 16,),
          Expanded(child: _appointmentButton()),
        ],
      ),
    );
  }

  Widget _chatButton() {
    return Container(
      height: 55, width: 55,
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(15)),
      child: const Icon(Icons.chat_bubble_outline, color: Colors.blue),
    );
  }

  Widget _appointmentButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: () {},
      child: const AppText(text: "Make an Appointment", color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}