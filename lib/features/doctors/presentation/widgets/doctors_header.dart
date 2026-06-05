import 'package:flutter/material.dart';


class DoctorDetailsHeader extends StatelessWidget {
  final String imageUrl;
  const DoctorDetailsHeader({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Hero(
          tag: imageUrl,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.36,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.contain),
            ),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Icon(Icons.favorite_border, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }
}