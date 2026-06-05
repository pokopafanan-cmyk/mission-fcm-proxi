import "package:flutter/material.dart";
import "../../../theme/app_color.dart";
import "../buttons/app_text_button.dart";
import "app_text.dart";


class MyDialog extends StatelessWidget {

  final String? title;
  final String? cancelText;
  final String? actionText;
  final Color btnColor;
  final Color? btnTextColor;
  final double? btnWidth;
  final VoidCallback actionOnPress;
  final double titleMarginBottom;
  final List<Widget> children;

  const MyDialog({
    super.key,
    this.title,
    this.cancelText,
    this.actionText,
    this.btnWidth,
    this.titleMarginBottom = 0,
    required this.children,
    required this.actionOnPress,
    this.btnColor = Colors.white,
    this.btnTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xFFE7E7E7),
      insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      contentPadding: const EdgeInsets.all(20),
      titlePadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0),),
        side: BorderSide(width: 2, color: AppColor.primaryColor),
      ),
      title: title != null ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        margin: EdgeInsets.only(bottom: titleMarginBottom),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: AppColor.primaryColor, width: 1.5,)),
        ),
        child: Center(
          child: AppText(
            text: title!,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            ellipsis: true,
          ),
        ),
      ) : null,
      scrollable: false,
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Material(
                color: AppColor.tertiaryColor,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...children,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: AppTextButton(
                    backgroundColor: btnColor,
                    width: btnWidth,
                    textColor: btnTextColor,
                    text: cancelText ?? "Annuler",
                    onPress: () => Navigator.of(context).pop(null),
                  ),
                ),
                const SizedBox(width: 20,),
                Flexible(
                  child: AppTextButton(
                    backgroundColor: btnColor,
                    textColor: btnTextColor,
                    width: btnWidth,
                    text: actionText ?? "Valider",
                    onPress: actionOnPress,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}


class MySimpleDialog extends StatelessWidget {

  final String? title;
  final double titleMarginBottom;
  final List<Widget> children;
  final Widget button;

  const MySimpleDialog({
    super.key,
    this.title,
    this.titleMarginBottom = 0,
    required this.children,
    this.button = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xFFE7E7E7),
      insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      contentPadding: const EdgeInsets.all(20),
      titlePadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0),),
        side: BorderSide(width: 2, color: AppColor.primaryColor),
      ),
      title: title != null ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        margin: EdgeInsets.only(bottom: titleMarginBottom),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: AppColor.primaryColor, width: 1.5,)),
        ),
        child: Center(child: AppText(text: title!, fontSize: 18, fontWeight: FontWeight.w500, ellipsis: true,)),
      ) : null,
      scrollable: false,
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Material(
                color: AppColor.tertiaryColor,
                child: ListView(
                  shrinkWrap: true,
                  children: children,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            button,
            //const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

class MyCameraDialog extends StatelessWidget {

  final String title;
  final String? imgPath;
  final bool addDivider;
  final double titleMarginBottom;
  final bool buttonMargin;
  final Widget button;
  final List<Widget> children;

  const MyCameraDialog({
    super.key,
    required this.title,
    this.imgPath,
    this.addDivider = true,
    this.titleMarginBottom = 0,
    this.buttonMargin = true,
    this.button = const SizedBox(),
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      backgroundColor: AppColor.backgroundColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      contentPadding: const EdgeInsets.only(),
      titlePadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0),),
        side: BorderSide(width: 2, color: AppColor.primaryColor),
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: EdgeInsets.only(bottom: titleMarginBottom),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: AppColor.primaryColor, width: 1.5,)),
        ),
        child: imgPath != null ? Row(
          children: [
            CircleAvatar(radius: 16, backgroundImage: AssetImage(imgPath!),),
            const SizedBox(width: 10,),
            Expanded(child: AppText(text: title, fontSize: 16, fontWeight: FontWeight.w500, ellipsis: true,),),
          ],
        ) : Center(child: AppText(text: title, fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black, ellipsis: true,)),
      ),
      scrollable: false,
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...children,
            SizedBox(height: 10,),

            if(addDivider)
              const Divider(color: AppColor.primaryColor, thickness: 1.5, height: 0.0,),
            Container(
              padding: buttonMargin ? const EdgeInsets.only(left: 0, right: 0, bottom: 25, top: 25) : null,
              child: button,
            ),
          ],
        ),
      ),
    );
  }
}


class CustomDialog extends StatelessWidget {

  final String title;
  final String? imgPath;
  final bool addDivider;
  final double titleMarginBottom;
  final bool buttonMargin;
  final Widget button;
  final List<Widget> children;
  final Color backgroundColor;

  const CustomDialog({
    super.key,
    required this.title,
    this.imgPath,
    this.addDivider = true,
    this.titleMarginBottom = 0,
    this.buttonMargin = true,
    this.button = const SizedBox(),
    required this.children,
    this.backgroundColor = AppColor.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      backgroundColor: backgroundColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      contentPadding: const EdgeInsets.only(),
      titlePadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0),),
        side: BorderSide(width: 2, color: AppColor.primaryColor),
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: EdgeInsets.only(bottom: titleMarginBottom),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: AppColor.primaryColor, width: 1.5,)),
        ),
        child: imgPath != null ? Row(
          children: [
            CircleAvatar(radius: 16, backgroundImage: AssetImage(imgPath!),),
            const SizedBox(width: 10,),
            Expanded(child: AppText(text: title, fontSize: 16, fontWeight: FontWeight.w500, ellipsis: true,),),
          ],
        ) : Center(child: AppText(text: title, fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black, ellipsis: true,)),
      ),
      scrollable: false,
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Material(
                color: Colors.transparent,
                child: ListView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 0),
                  shrinkWrap: true,
                  children: [
                    ...children,
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            if(addDivider)
              const Divider(color: AppColor.primaryColor, thickness: 1.5, height: 0.0,),
            Container(
              padding: buttonMargin ? const EdgeInsets.only(left: 0, right: 0, bottom: 25, top: 25) : null,
              child: button,
            ),
          ],
        ),
      ),
    );
  }
}
