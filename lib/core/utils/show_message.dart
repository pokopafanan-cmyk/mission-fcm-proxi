import "package:flutter/material.dart";
import 'package:flutter_styled_toast/flutter_styled_toast.dart' as styled_toast;
import "../shared/widgets/common/app_text.dart";


class AppMessage {

  AppMessage._();

  static void showToast({
    required String msg,
    bool isBottomPosition = false,
    bool isError = true,
  }) {
    styled_toast.showToast(
      msg,
      toastHorizontalMargin: 15,
      backgroundColor: isError ? Colors.redAccent.shade200 : Colors.green,
      position: isBottomPosition ? styled_toast.StyledToastPosition.bottom : styled_toast.StyledToastPosition.top,
    );
  }

  static void showSnackBar({required BuildContext context, required String msg}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
          margin: const EdgeInsets.all(15),
          backgroundColor: Colors.black,
          content: AppText(text: msg, color: Colors.white,),
        ),
      );
  }
}

