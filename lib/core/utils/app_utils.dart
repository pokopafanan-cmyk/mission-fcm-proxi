import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:string_validator/string_validator.dart';
import '../error/failure.dart';
import 'app_logger.dart';
import 'show_message.dart';

class AppUtils {

  String rewriteString(String str, String nbre) {
    str = str.trim().replaceAll(" ", "");
    str = str.split("").reversed.join("");
    str = str.replaceAllMapped(RegExp(r".{" + nbre + "}"), (match) => "${match.group(0)} ");
    str = str.split("").reversed.join("");
    str = str.trim();

    return str;
  }


  String formatNumberGroups(String value, int groupSize) {

    final clean = value.replaceAll(" ", "");
    final reversed = clean.split("").reversed.join("");
    final pattern = '.{$groupSize}';

    final grouped = reversed.replaceAllMapped(RegExp(pattern), (m) => "${m.group(0)} ");

    return grouped.split("").reversed.join("").trim();
  }




  Future<String> getPath() async {
    // final Directory? tempDir = await getExternalStorageDirectory();
    Directory directory = Directory("");
    if (Platform.isAndroid) {
      directory = (await getExternalStorageDirectory())!;
    } else {
      directory = (await getApplicationDocumentsDirectory());
    }
    final filePath = Directory('${directory.path}/alfiles');
    if (await filePath.exists()) {
      return filePath.path;
    } else {
      await filePath.create(recursive: true);
      return filePath.path;
    }
  }

  Future<bool> checkFileExit(String filePath) async {
    return await File(filePath).exists();
  }


  Future<void> openFile(String filePath) async {
    OpenResult openResult = await OpenFile.open(filePath);
    AppLogger.printer('-------- ${openResult.message} ${openResult.type}');
  }



  /// check str is not empty
  bool isStrValid(String str, {int minLength = 1}) {
    str = str.trim();

    if (str.isEmpty) return false;

    if (str.length < minLength) return false;

    return true;
  }

  /// check Gmail is valide
  bool isGmailValid(String email) {
    email = email.trim();

    if (!isEmail(email)) return false;

    if (!email.endsWith('@gmail.com')) return false;

    return true;
  }

  bool isMobileValid(String mobile, {String keywords = ''}) {

    mobile = mobile.trim().replaceAll(' ', '');

    if (mobile.isEmpty) return false;

    if (mobile.length != 10) return false;

    if (!(mobile.startsWith('01') || mobile.startsWith('05') || mobile.startsWith('07'))) return false;

    if (!isNumericOnly(mobile)) return false;

    if (keywords.isNotEmpty) {
      if (keywords == 'Orange Money') {
        return mobile.startsWith('07');
      }
      if (keywords == 'MTN Money') {
        return mobile.startsWith('05');
      }
      if (keywords == 'Moov Money') {
        return mobile.startsWith('01');
      }
    }

    return true;
  }

  bool isYearValid(String year) {
    year = year.trim();

    final now = DateTime.now().year;
    final minYear = now - 60;

    if (year.isEmpty || !RegExp(r'^\d{4}$').hasMatch(year)) return false;

    final intYear = int.tryParse(year);

    if (intYear == null || intYear > now || intYear < minYear) return false;

    return true;
  }



  Future<bool> verifyAndSaveCodePin(BuildContext context, String codePin, String repeatCodePin) async {

    codePin = codePin.trim().replaceAll(" ", "");
    repeatCodePin = repeatCodePin.trim().replaceAll(" ", "");

    if(codePin == "" || repeatCodePin == "") {
      AppMessage.showToast(msg: "Veuillez entrer un code PIN"); return false;
    }
    if(codePin.length != 4 || repeatCodePin.length != 4) {
      AppMessage.showToast(msg: "4 chiffres pour le code PIN"); return false;
    }
    if(codePin != repeatCodePin) {
      AppMessage.showToast(msg: "Code PIN différent"); return false;
    }

    return false;
  }

  bool visaCarteInfoValidate(BuildContext context, String carteName, String carteNumber, String expireDate, String carteCode,) {

    carteName = carteName.trim();
    carteNumber = carteNumber.trim().replaceAll(" ", "");
    expireDate = expireDate.trim().replaceAll(" ", "");
    carteCode = carteCode.trim().replaceAll(" ", "");

    if(carteName == "" || carteNumber == "" || expireDate == "" || carteCode == "") {
      AppMessage.showToast(msg: "Veuillez renseigner tous les champs obligatoires"); return false;
    }

    if(carteNumber.length != 16) {
      AppMessage.showToast(msg: "16 chiffres pour le numéro de la carte"); return false;
    }
    if(!isNumericOnly(carteNumber)) {
      AppMessage.showToast(msg: "Le numéro de la carte doit être une chaîne numerique"); return false;
    }

    if(expireDate.length != 5) {
      AppMessage.showToast(msg: "5 chiffres pour la date d\'expiration"); return false;
    }

    if(carteCode.length != 3) {
      AppMessage.showToast(msg: "3 chiffres pour le code de la carte"); return false;
    }
    if(!isNumericOnly(carteCode)) {
      AppMessage.showToast(msg: "Une chaîne numerique pour le code de la carte"); return false;
    }

    return true;
  }

  bool codePinValidate(BuildContext context, String pin, String repeatPin) {

    pin = pin.trim(); repeatPin = repeatPin.trim();

    if(pin == "" || repeatPin == "") {
      AppMessage.showToast(msg: "Veuillez renseigner le code PIN", isBottomPosition: false);
      return false;
    }
    if(pin.length != 4 || repeatPin.length != 4) {
      AppMessage.showToast(msg: "4 chiffres pour le code PIN", isBottomPosition: false); return false;
    }
    if(!isNumericOnly(pin) || !isNumericOnly(repeatPin)) {
      AppMessage.showToast(msg: "Le code PIN doit être une chaîne numerique", isBottomPosition: false); return false;
    }
    if(pin != repeatPin) {
      AppMessage.showToast(msg: "Le code PIN et sa confirmation sont différents", isBottomPosition: false); return false;
    }
    return true;
  }

  bool verifyPassword(BuildContext context, String password) {

    //password = password.trim();
    if(password == "") {
      AppMessage.showToast(msg: "Veuillez entrer votre mot de passe", isBottomPosition: false);
      return false;
    }
    return true;
  }

  String? checkMobile(BuildContext context, String phoneNumber, String indicatif, {String? keyWord}) {

    String mobile = phoneNumber.trim().replaceAll(" ", "");

    if(mobile == "" || mobile.isEmpty) {
      AppMessage.showToast(msg: "Veuillez entrer un numéro de mobile"); return null;
    }

    if(!isNumericOnly(mobile)) {
      AppMessage.showToast(msg: "Le numéro de mobile doit être une chaîne numerique"); return null;
    }

    if(indicatif == "+225") {
      if(mobile.length != 10) {
        AppMessage.showToast(msg: "10 chiffres pour le numéro de mobile"); return null;
      }

      if(!mobile.startsWith("01") && !mobile.startsWith("05") && !mobile.startsWith("07")) {
        AppMessage.showToast(msg: "Entrez un numéro de mobile commençant par 01, 05 ou 07"); return null;
      }
    } else {
      AppMessage.showToast(msg: "Indicatif du pays n'est connu"); return null;
    }

    return "$indicatif ${rewriteString(mobile, "2")}";
  }


  String formatHHMMSS(int seconds) {
    final hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    final minutes = (seconds / 60).truncate();

    final hoursStr = (hours).toString().padLeft(2, "0");
    final minutesStr = (minutes).toString().padLeft(2, "0");
    final secondsStr = (seconds % 60).toString().padLeft(2, "0");

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }
    return "$hoursStr:$minutesStr:$secondsStr";
  }

  /// check if the string contains only numbers
  bool isNumericOnly(String str) {
    RegExp numeric = RegExp(r"^-?[0-9]+$");
    return numeric.hasMatch(str);
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
