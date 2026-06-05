
import "package:flutter/material.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";
import "../../../theme/app_color.dart";
import '../../../theme/app_theme.dart';
import "app_text.dart";
import "show_app_dialog.dart";


class AppLoader {

  static Future<void> show({
    required BuildContext context,
    String message = "Patientez s'il vous plait...",
    bool dismissible = false,
  }) async {
    await showAppDialog<void>(
      context: context,
      useRootNavigator: true,
      direction: AxisDirection.left,
      child: PopScope(
        canPop: dismissible,
        child: _AppLoaderDialog(message: message),
      ),
    );
  }

  static Future<void> showWithProgress({
    required BuildContext context,
    bool dismissible = false,
  }) async {
    await showAppDialog<void>(
      context: context,
      direction: AxisDirection.left,
      child: PopScope(
        canPop: dismissible,
        child: _AppLoaderDialog2(),
      ),
    );
  }


  // static void hide(BuildContext context) {
  //   if(ModalRoute.of(context)?.isCurrent != true) {
  //     Navigator.pop(context);
  //   }
  // }

  static void hide(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);

    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  // static void hide(BuildContext context) {
  //   if (Navigator.canPop(context)) {
  //     Navigator.of(context, rootNavigator: true).pop();
  //   }
  // }

}


class _AppLoaderDialog extends StatelessWidget {

  final String message;

  const _AppLoaderDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      contentPadding: const EdgeInsets.only(top: 14.0, bottom: 14.0, right: 16.0, left: 10.0),
      backgroundColor: const Color(0xFFF2F2F2),
      elevation: 5,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 2.5),
                ),
                const SizedBox(width: 18,),
                AppText(text: message, fontSize: 14, color: Colors.grey.shade700),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _AppLoaderDialog2 extends StatelessWidget {

  const _AppLoaderDialog2({super.key,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.36),
      contentPadding: const EdgeInsets.only(top: 14.0, bottom: 14.0, right: 14.0, left: 14.0),
      backgroundColor: const Color(0xFFF2F2F2),
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxWidth,
            child: Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: AppColor.primaryColor,
                size: 50,
              ),
            ),
          );
        },
      ),
    );
  }
}


// void userLogout(String answer, BuildContext context) {
//   if (answer == '-1') {
//     WidgetsBinding.instance.addPostFrameCallback((_){
//       context.read<SignInBloc>().add(const LoggedOut());
//       Navigator.of(context).pushNamedAndRemoveUntil(
//         RouteConfig.signInScreen, (Route route) => false,
//       );
//     });
//   }
// }




