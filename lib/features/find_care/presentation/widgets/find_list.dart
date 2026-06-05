

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/shared/widgets/common/app_rating_bar.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';
import '../../data/model/find_care_model.dart';

class FindCareList extends StatelessWidget {
  final FindCare care;

  const FindCareList({
    super.key,
    required this.care,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.grey1Color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: AppColor.grey1Color),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(13, 20, 16, 20),
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(care.iconPath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: care.name,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                AppText(text: care.specialty, fontSize: 14),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: AppRatingBar(rating: 4),
                ),
                Row(
                  children: [

                    InkWell(
                      onTap: () => context.pushNamed(RoutePath.findDetails.name),
                      child: AppText(
                        text: "View detail",
                        fontSize: 13,
                        color: AppColor.primaryColor,
                      ),
                    ),

                    Container(
                      height: 20,
                      width: 1,
                      color: Colors.grey[300],
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                    ),

                    Flexible(
                      child: AppText(
                        text: "Create appoint........",
                        fontSize: 13,
                        color: AppColor.primaryColor,
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
}