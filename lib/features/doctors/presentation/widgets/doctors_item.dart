
import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';
import '../../data/model/list_doctors.dart';
import 'app_rating_bar.dart';



class DoctorItem extends StatelessWidget {
  final ListDoctors doctor;
  final VoidCallback onTap;

  const DoctorItem({
    super.key,
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(doctor.imageUrl),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(width: 16,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: doctor.name,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.blackColor,
                  ),

                  SizedBox(height: 4,),

                  Row(
                    children: [
                      AppText(
                        text: doctor.specialty,
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: AppText(text: "•", color: Colors.grey[400]),
                      ),
                      Flexible(
                        child: AppText(
                          text: doctor.hospital,
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8,),
                  AppRatingBar(rating: doctor.rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}