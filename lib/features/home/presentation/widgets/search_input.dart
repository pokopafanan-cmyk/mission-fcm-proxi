import 'package:flutter/material.dart';
import '../../../../core/theme/app_color.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchInput({
    super.key,
    required this.controller,
    this.hintText = 'Rechercher un praticien...',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      SizedBox(height: 15,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: AppColor.primaryColor.withOpacity(0.6),
                size: 22,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColor.primaryColor.withValues(alpha: 0.5),width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: AppColor.primaryColor,
                  width: 1,
                ),
              ),

            ),
          ),
        ),
      SizedBox(height: 10,),
      ],
    );
  }
}