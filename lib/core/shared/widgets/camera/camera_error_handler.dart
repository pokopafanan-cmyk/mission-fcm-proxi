import 'package:camera/camera.dart';

/// Classe pour gérer les erreurs de la caméra

class CameraErrorHandler {
  static String getErrorMessage(CameraException e) {
    switch (e.code) {
      case 'CameraAccessDenied':
        return "Vous avez refusé l'accès à la caméra.";
      case 'CameraAccessDeniedWithoutPrompt':
        return "Veuillez accéder à l'application Paramètres pour activer l'accès à la caméra.";
      case 'CameraAccessRestricted':
        return "L'accès à la caméra est restreint.";
      case 'AudioAccessDenied':
        return "Vous avez refusé l'accès audio.";
      case 'AudioAccessDeniedWithoutPrompt':
        return "Veuillez accéder à l'application Paramètres pour activer l'accès audio.";
      case 'AudioAccessRestricted':
        return "L'accès audio est restreint.";
      default:
        return "Erreur de caméra: ${e.description}";
    }
  }
}