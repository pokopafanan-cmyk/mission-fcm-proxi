import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../utils/show_message.dart';
import '../common/app_text.dart';
import 'camera_controls.dart';
import 'camera_error_handler.dart';
import 'img_card.dart';


class CameraView extends StatefulWidget {

  const CameraView({
    super.key,
    required this.onTakePicture,
    this.isPhotoIdentity = false,
    this.isSelfie = false,
  });

  final ValueChanged<XFile> onTakePicture;
  final bool isPhotoIdentity;
  final bool isSelfie;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {

  CameraController? _controller;
  IconData flashIcon = Icons.flash_off_rounded;
  String errorMessage = "";

  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCameraController(cameras[0]);
  }


  Future<void> onNewCameraSelected() async {
    final lensDirection =  _controller!.description.lensDirection;
    CameraDescription cameraDescription;
    if(lensDirection == CameraLensDirection.front) {
      cameraDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
    } else {
      cameraDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
    }

    if (_controller != null) {
      return _controller!.setDescription(cameraDescription);
    } else {
      return _initializeCameraController(cameraDescription);
    }
  }

  Future<void> _initializeCameraController(CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription, ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _controller = cameraController;

    // If the controller is updated then update_user the UI.
    cameraController.addListener(() {
      if(mounted) {
        setState(() {});
      }
      if(cameraController.value.hasError) {
        AppMessage.showToast(msg: "Camera error ${cameraController.value.errorDescription}");
      }
    });

    try {
      await cameraController.initialize();

      if(widget.isSelfie && _controller != null) {
        final cameraDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
        _controller!.setDescription(cameraDescription);
      }

      await Future.wait(<Future<Object?>>[
        cameraController.getMinExposureOffset().then((double value) => _minAvailableExposureOffset = value),
        cameraController.getMaxExposureOffset().then((double value) => _maxAvailableExposureOffset = value),
      ]);
    } on CameraException catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = CameraErrorHandler.getErrorMessage(e);
          AppMessage.showToast(msg: errorMessage);
        });
      }
    }

    if(mounted) {
      setState(() {});
    }
  }

  Future takePicture() async {
    final CameraController? cameraController = _controller;
    if(cameraController == null || !cameraController.value.isInitialized) {
      if (mounted) {
        setState(() {
          errorMessage = "Erreur: sélectionnez d'abord une caméra.";
          AppMessage.showToast(msg: errorMessage);
        });
      }
      return;
    }
    if(cameraController.value.isTakingPicture) return;

    try {

      final XFile xfile = await cameraController.takePicture();
      widget.onTakePicture(xfile);

    } on CameraException catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = CameraErrorHandler.getErrorMessage(e);
          AppMessage.showToast(msg: errorMessage);
        });
      }
    }
  }

  Future<void> setFlashMode(FlashMode mode) async {

    try {
      await _controller!.setFlashMode(mode);
    } on CameraException catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = CameraErrorHandler.getErrorMessage(e);
          AppMessage.showToast(msg: errorMessage);
        });
      }
      rethrow;
    }
  }

  void onSetFlashModeOnPress() {

    if(_controller == null) {
      return;
    }
    FlashMode mode;
    if(_controller!.value.flashMode != FlashMode.torch) {
      mode = FlashMode.torch;
      flashIcon = Icons.flash_on_rounded;
    } else {
      mode = FlashMode.off;
      flashIcon = Icons.flash_off_rounded;
    }

    setFlashMode(mode).then((_) {
      if(mounted) {
        setState(() {});
      }
    });
  }


  // Select file in gallery
  void onPick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["png", "jpeg", "jpg"],
    );

    if (result == null) return;
    widget.onTakePicture(result.xFiles.first);
  }


  @override
  void dispose() {
    _controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if(cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if(state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final deviceHeight = screenHeight - (statusBarHeight - kToolbarHeight);
    double height = deviceHeight <= 672 ? deviceHeight * 0.34 * 0.8 : deviceHeight * 0.46 * 0.8;

    if(errorMessage.isNotEmpty) {
      return ImgCard(
        height: height,
        child: Center(
          child: AppText(
            text: errorMessage,
            color: Colors.redAccent,
          ),
        ),
      );
    }
    final CameraController? cameraController = _controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
    // if (cameraController != null) {
      return ControlsLoading(
        isPhotoIdentity: widget.isPhotoIdentity,
        isSelfie: widget.isSelfie,
        height: height,
      );
    } else {
      return CameraControls(
        cameraController: _controller!,
        onNewCameraSelected: onNewCameraSelected,
        onSetFlashModeOnPress: onSetFlashModeOnPress,
        takePicture: takePicture,
        onPick: onPick,
        isPhotoIdentity: widget.isPhotoIdentity,
        isSelfie: widget.isSelfie,
        flashIcon: flashIcon,
        height: height,
      );
    }
  }
}

