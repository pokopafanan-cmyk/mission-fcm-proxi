// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../app/router/route_path.dart';
// import '../../../../core/shared/extensions/extensions.dart';
// import '../../../../core/shared/widgets/common/app_text.dart';
// import '../../data/model/list_doctors.dart';
// import '../widgets/doctors_header.dart';
// import '../widgets/doctors_stats_row.dart';
//
// class DoctorDetailsScreen extends StatelessWidget {
//   final ListDoctors doctor;
//
//   const DoctorDetailsScreen({super.key, required this.doctor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             DoctorDetailsHeader(imageUrl: doctor.imageUrl),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AppText(text: doctor.name, fontSize: 20, fontWeight: FontWeight.bold),
//                   8.height,
//                   AppText(text: "${doctor.specialty} • ${doctor.hospital}", color: Colors.grey),
//                   24.height,
//                   DoctorStatsRow(rating: doctor.rating),
//                   24.height,
//                   const AppText(text: "À propos du docteur", fontSize: 18, fontWeight: FontWeight.bold),
//                   12.height,
//                   AppText(
//                     text: "Dr. ${doctor.name} is a specialist in ${doctor.specialty} at ${doctor.hospital}. "
//                         "He has years of experience and is known for his dedication to patient care. "
//                         "He has years of experience and is known for his dedication to patient care. "
//                         "He has years of experience and is known for his dedication to patient care. "
//                         "He has years of experience and is known for his dedication to patient care. "
//                         "He has years of experience and is known for his dedication to patient care. ",
//                     fontSize: 14,
//                     color: Colors.grey[700],
//                     height: 1.5,
//                     textAlign: TextAlign.justify,
//                   ),
//                   15.height,
//                   Row(
//                     children: [
//                       _squareIconButton(
//                         icon: Icons.chat_bubble_outline,
//                         color: Colors.blue.shade600,
//                         onTap: () { },
//                       ),
//                       15.width,
//                       Expanded(
//                         child: _primaryButton(
//                           label: "Make an Appointment",
//                           color: Colors.green.shade600,
//                           onTap: () => context.pushNamed(RoutePath.medicalCard.name),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _squareIconButton({required IconData icon, required Color color, required VoidCallback onTap}) {
//     return Material(
//       color: color,
//       borderRadius: BorderRadius.circular(12),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: SizedBox(
//           height: 50,
//           width: 50,
//           child: Icon(icon, color: Colors.white),
//         ),
//       ),
//     );
//   }
//
//   Widget _primaryButton({required String label, required Color color, required VoidCallback onTap}) {
//     return Material(
//       color: color,
//       borderRadius: BorderRadius.circular(12),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           height: 50,
//           alignment: Alignment.center,
//           child: AppText(
//             text: label,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/shared/extensions/extensions.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../data/model/list_doctors.dart';
import '../widgets/doctors_header.dart';
import '../widgets/doctors_stats_row.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final ListDoctors doctor;

  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          DoctorDetailsHeader(imageUrl: doctor.imageUrl),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: doctor.name,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 8,),
                AppText(
                  text: "${doctor.specialty} • ${doctor.hospital}",
                  color: Colors.grey,
                ),

                SizedBox(height: 24,),

                DoctorStatsRow(rating: doctor.rating),

               SizedBox(height: 24,),

                const AppText(
                  text: "À propos du docteur",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),

                SizedBox(height: 12,),
                AppText(
                  text:
                  "Dr. ${doctor.name} is a specialist in ${doctor.specialty} at ${doctor.hospital}. "
                      "He has years of experience and is known for his dedication to patient care. "
                      "He has years of experience and is known for his dedication to patient care. "
                      "He has years of experience and is known for his dedication to patient care. "
                      "He has years of experience and is known for his dedication to patient care. "
                      "He has years of experience and is known for his dedication to patient care.",
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.5,
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 15,),

                Row(
                  children: [
                    _squareIconButton(
                      icon: Icons.chat_bubble_outline,
                      color: Colors.blue.shade600,
                      onTap: () {},
                    ),

                    SizedBox(width: 15,),

                    Expanded(
                      child: _primaryButton(
                        label: "Make an Appointment",
                        color: Colors.green.shade600,
                        onTap: () =>
                            context.pushNamed(RoutePath.medicalCard.name),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _squareIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 50,
          width: 50,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  Widget _primaryButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: AppText(
            text: label,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}