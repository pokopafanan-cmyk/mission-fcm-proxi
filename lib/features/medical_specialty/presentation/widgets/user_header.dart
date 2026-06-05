
import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';

class HomeUserHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;

  const HomeUserHeader({super.key, this.onNotificationTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [

          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 24,
                child: const AppText(
                  text: "JD",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                ),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  height: 11,
                  width: 11,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 12,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Bonjour ",
                  fontSize: 12,
                  color: AppColor.greyColor,
                ),
                AppText(
                  text: "John Doe William",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.blackColor,
                ),
              ],
            ),
          ),

          Stack(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: onNotificationTap,
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColor.blackColor,
                    size: 22,
                  ),
                ),
              ),

              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}