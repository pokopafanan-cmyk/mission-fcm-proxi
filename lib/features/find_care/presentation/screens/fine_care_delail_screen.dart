
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proxi/core/shared/widgets/common/app_text.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/shared/widgets/common/custom_app_bar.dart';
import '../../../../core/theme/app_color.dart';
import '../../data/model/appointment.dart';
import '../widgets/appointment_item.dart';
import '../widgets/find_header.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int? expandedIndex;

  void toggle(int index) {
    setState(() {
      expandedIndex = (expandedIndex == index) ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Soins fins"),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(RoutePath.appBooking.name),
        backgroundColor: AppColor.primaryColor,
        label: AppText(text: 'Create Appointment', color: AppColor.whiteColor,),
        icon: const Icon(Icons.add, color: Colors.white),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          FindHeader(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: Color(0xFFEEEEEE), thickness: 1),
          ),
          ...List.generate(AppointmentData.rend.length, (index) {
            final rdv = AppointmentData.rend[index];
            return AppointmentItem(
              appointment: rdv,
              isExpanded: expandedIndex == index,
              onToggle: () => toggle(index),
            );
          }),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}