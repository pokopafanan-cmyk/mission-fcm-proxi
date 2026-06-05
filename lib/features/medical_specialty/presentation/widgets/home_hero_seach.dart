
import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';
import '../../../home/presentation/widgets/search_input.dart';

class HomeHeroSearch extends StatelessWidget {
  final TextEditingController? searchController;

  const HomeHeroSearch({super.key, this.searchController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.only(top: 8, bottom: 13),
          child: RichText(
            text: TextSpan(
              text: "Trouver ",
              style: const TextStyle(
                fontSize: 22,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: "votre spécialiste",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SearchInput(
          controller: searchController ?? TextEditingController(),
        ),
      ],
    );
  }
}