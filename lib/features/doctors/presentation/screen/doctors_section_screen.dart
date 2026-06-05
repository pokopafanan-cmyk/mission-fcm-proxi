import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_path.dart';
import '../widgets/doctors_data.dart';
import '../widgets/doctors_item.dart';

class DoctorsSectionScreen extends StatelessWidget {
  const DoctorsSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final doctor = ListDoctorsData.doctors[index];

            return Padding(
              padding: EdgeInsets.only(bottom: 12, left: 12, right: 12),
              child: DoctorItem(
                doctor: doctor,
                onTap: () => context.pushNamed(
                  RoutePath.doctorsDetails.name,
                  extra: doctor,
                ),
              ),
            );
          },
          childCount: ListDoctorsData.doctors.length,
        ),
      ),
    );
  }
}