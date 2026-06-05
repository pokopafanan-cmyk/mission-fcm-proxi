import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/shared/widgets/common/custom_app_bar.dart';
import '../../../../core/theme/app_color.dart';

class MakingAnAppointmentScreen extends StatelessWidget {
  const MakingAnAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, color: AppColor.primaryColor),
                const SizedBox(width: 14),
                AppText(
                  text: "August 2022",
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(width: 14),
                const Icon(Icons.keyboard_arrow_down, color: AppColor.blackColor),
              ],
            ),
            const SizedBox(height: 20),
            _appointmentDay(
              dayNumber: 17,
              dayOfWeek: "SUN",
              appointments: [
                _appointmentSlot(context, "9 - 10 am"),
              ],
            ),
            _appointmentDay(dayNumber: 18, dayOfWeek: "MON", appointments: []),
            _appointmentDay(
              dayNumber: 19,
              dayOfWeek: "TUE",
              appointments: [
                _appointmentSlot(context, "3:30 - 4:30 pm"),
              ],
            ),
            _appointmentDay(dayNumber: 20, dayOfWeek: "WED", appointments: []),
            _appointmentDay(
              dayNumber: 31,
              dayOfWeek: "SUN",
              appointments: [
                _appointmentSlot(context, "9 - 10 am"),
              ],
            ),
            _appointmentDay(dayNumber: 12, dayOfWeek: "MON", appointments: []),
            _appointmentDay(
              dayNumber: 20,
              dayOfWeek: "WED",
              appointments: [
                _appointmentSlot(context, "9 - 10 am"),
              ],
            ),
            _appointmentDay(dayNumber: 12, dayOfWeek: "MON", appointments: []),
          ],
        ),

      ),
    );
  }

  Widget _appointmentDay({
    required int dayNumber,
    required String dayOfWeek,
    required List<Widget> appointments,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Column(
              children: [
                AppText(text: dayNumber.toString(), color: AppColor.blackColor, fontWeight: FontWeight.bold,),
                AppText(text: dayOfWeek),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: appointments,
            ),
          ),
        ],
      ),
    );
  }

  Widget _appointmentSlot(BuildContext context, String timeSlot) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AppText(
            text: "Appointment",
            color: Colors.white,
          ),
         AppText(
            text: timeSlot,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
