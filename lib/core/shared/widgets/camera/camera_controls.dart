import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../buttons/app_rounded_btn.dart';
import 'img_card.dart';

class ControlsLoading extends StatelessWidget {

  final bool isPhotoIdentity;
  final bool isSelfie;
  final double height;

  const ControlsLoading({
    super.key,
    required this.isPhotoIdentity,
    required this.height,
    required this.isSelfie,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final width = constraints.maxWidth; // 282
            return ImgCard(
              height: isPhotoIdentity ? ((width * 56) / 86) : height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        const SizedBox(height: 20,),
        Center(
          child: AppRoundedBtn(
            backgroundColor: const Color(0xFFD9D9D9).withValues(alpha: .8),
            btnSize: 60, onPress: () {  },
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: !isSelfie,
              child: AppRoundedBtn(
                backgroundColor: const Color(0xFFD9D9D9).withValues(alpha: .8),
                btnSize: 50,
                onPress: () {  },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),

            AppRoundedBtn(
              backgroundColor: const Color(0xFFD9D9D9).withValues(alpha: .8),
              btnSize: 50,
              onPress: () {  },
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Visibility(
              visible: !isSelfie,
              child: AppRoundedBtn(
                backgroundColor: const Color(0xFFD9D9D9).withValues(alpha: .8),
                btnSize: 50,
                onPress: () {  },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class CameraControls extends StatelessWidget {

  final bool isPhotoIdentity;
  final bool isSelfie;
  final double height;
  final IconData flashIcon;
  final VoidCallback takePicture;
  final VoidCallback onPick;
  final VoidCallback onSetFlashModeOnPress;
  final VoidCallback onNewCameraSelected;
  final CameraController cameraController;

  const CameraControls({
    super.key,
    required this.isPhotoIdentity,
    required this.isSelfie,
    required this.height,
    required this.takePicture,
    required this.flashIcon,
    required this.onSetFlashModeOnPress,
    required this.onNewCameraSelected,
    required this.onPick,
    required this.cameraController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).primaryColor, width: 1.5, style: BorderStyle.solid),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final width = constraints.maxWidth; // 282
                  return SizedBox(
                    width: width,
                    height: isPhotoIdentity ? ((width * 56) / 86) : height,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        height: height,
                        child: CameraPreview(cameraController),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 20,),
          Center(
            child: AppRoundedBtn(
              btnSize: 60,
              onPress: takePicture,
              icon: Icons.camera_alt_rounded,
            ),
          ),
          const SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                visible: !isSelfie,
                child: IconButton(
                  icon: const Icon(Icons.photo_library_rounded, color: Colors.black,),
                  onPressed: onPick ,
                ),
              ),
              IconButton(
                icon: Icon(flashIcon, color: Colors.black,),
                onPressed: onSetFlashModeOnPress,
              ),
              Visibility(
                visible: !isSelfie,
                child: IconButton(
                  icon: const Icon(Icons.cameraswitch_outlined, color: Colors.black,),
                  onPressed: onNewCameraSelected,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

