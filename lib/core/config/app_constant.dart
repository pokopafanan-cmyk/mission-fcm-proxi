import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppConstant {

  // sharedPreferences keys
  static const String appLockedKey = 'app_locked';
  static const String isLoggedInKey = 'is_logged_in';
  static const String codePinKey = 'code_pin';
  static const String firstLaunchKey = 'first_launch';
  static const String codeOptKey = 'code_otp';
  static const String appKeysSessionKey = 'app_keys_session';

  static const String currentUserKey = 'current_user';
  static const String pinCodeKey = 'pin_code';
  static const String authTokenKey = 'auth_token';
  static const String tokenExpiryKey = 'token_expiry';




  static final MaskTextInputFormatter phoneNumberFormatCi = MaskTextInputFormatter(mask: '## ## ## ## ##', filter: {'#': RegExp(r'[0-9]')});
  static final MaskTextInputFormatter codeSocieteFormat = MaskTextInputFormatter(mask: '########', filter: {'#': RegExp(r'[0-9]')});
  static final MaskTextInputFormatter phoneNumberFormatOther = MaskTextInputFormatter(mask: '## ## ## ##', filter: {'#': RegExp(r'[0-9]')});
  static final MaskTextInputFormatter phoneNumberFormatGuinea = MaskTextInputFormatter(mask: '## ## ## ###', filter: {'#': RegExp(r'[0-9]')});
  static final MaskTextInputFormatter codePinFormat = MaskTextInputFormatter(mask: '####', filter: {'#': RegExp(r'[0-9]')});
  static final expireDateFormat = MaskTextInputFormatter(mask: '##/##', filter: {'#': RegExp(r'[0-9]') });
  static final dateEmissionFormat = MaskTextInputFormatter(mask: '##/##/####', filter: {'#': RegExp(r'[0-9]') });
  static final yearFormat = MaskTextInputFormatter(mask: '####', filter: {'#': RegExp(r'[0-9]') });
  static final numberCarteFormat = MaskTextInputFormatter(mask: '#### #### #### ####', filter: {'#': RegExp(r'[0-9]') });
  static final codeCarteFormat = MaskTextInputFormatter(mask: '###', filter: {'#': RegExp(r'[0-9]') });
}