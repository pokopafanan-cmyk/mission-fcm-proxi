import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImgCard extends StatelessWidget {

  final double height;

  const ImgCard({
    super.key,
    required this.child,
    required this.height,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1.5,
          style: BorderStyle.solid,
        ),
      ),
      child: child,
    );
  }
}


class ImageView extends StatelessWidget {


  const ImageView({
    super.key,
    required this.width,
    required this.height,
    required this.xFile,
  });

  final double width;
  final double height;
  final XFile xFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(File(xFile.path)),
        ),
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
      ),
    );
  }
}