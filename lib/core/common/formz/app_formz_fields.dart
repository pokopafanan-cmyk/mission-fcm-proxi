import 'package:formz/formz.dart';
import 'package:string_validator/string_validator.dart';

// === Login ===
enum LoginValidationError { empty, tooShort }

class LoginInput extends FormzInput<String, LoginValidationError> {

  const LoginInput.pure([super.value = '']) : super.pure();
  const LoginInput.dirty([super.value = '']) : super.dirty();

  @override
  LoginValidationError? validator(String value) {
    if (value.isEmpty) return LoginValidationError.empty;
    if (value.length < 3) return LoginValidationError.tooShort;
    return null;
  }
}

extension LoginValidationErrorExtension on LoginValidationError {
  String get message {
    switch (this) {
      case LoginValidationError.empty:
        return 'Le login est requis';
      case LoginValidationError.tooShort:
        return 'Le login doit contenir au moins 3 caractères';
    }
  }
}

// === Nom ===
enum NomValidationError { empty }

class NomInput extends FormzInput<String, NomValidationError> {

  const NomInput.pure([super.value = '']) : super.pure();
  const NomInput.dirty([super.value = '']) : super.dirty();

  @override
  NomValidationError? validator(String value) {
    if (value.isEmpty) return NomValidationError.empty;
    return null;
  }
}

extension NomValidationErrorExtension on NomValidationError {
  String get message {
    switch (this) {
      case NomValidationError.empty:
        return 'Le nom est requis';
    }
  }
}


// === Prénoms ===
enum PrenomsValidationError { empty }

class PrenomsInput extends FormzInput<String, PrenomsValidationError> {

  const PrenomsInput.pure([super.value = '']) : super.pure();
  const PrenomsInput.dirty([super.value = '']) : super.dirty();

  @override
  PrenomsValidationError? validator(String value) {
    if (value.isEmpty) return PrenomsValidationError.empty;
    return null;
  }
}

extension PrenomsValidationErrorExtension on PrenomsValidationError {
  String get message {
    switch (this) {
      case PrenomsValidationError.empty:
        return 'Les prénoms sont requis';
    }
  }
}


// === Email ===
enum EmailValidationError { empty, invalid }

class EmailInput extends FormzInput<String, EmailValidationError> {

  const EmailInput.pure([super.value = '']) : super.pure();
  const EmailInput.dirty([super.value = '']) : super.dirty();

  static final _emailRegExp = RegExp(r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$');

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    // if (!_emailRegExp.hasMatch(value)) return EmailValidationError.invalid;
    if (!value.isEmail) return EmailValidationError.invalid;
    return null;
  }
}

extension EmailValidationErrorExtension on EmailValidationError {
  String get message {
    switch (this) {
      case EmailValidationError.empty:
        return 'L\'email est requis';
      case EmailValidationError.invalid:
        return 'Veuillez entrer un email valide';
    }
  }
}


// === Password ===
enum PasswordValidationError { empty, tooShort }

class PasswordInput extends FormzInput<String, PasswordValidationError> {

  const PasswordInput.pure([super.value = '']) : super.pure();
  const PasswordInput.dirty([super.value = '']) : super.dirty();
  static final _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    // if (value.length < 6) return PasswordValidationError.tooShort;
    // if (!_passwordRegex.hasMatch(value)) return PasswordValidationError.invalid;

    return null;
  }
}

extension PasswordValidationErrorExtension on PasswordValidationError {
  String get message {
    switch (this) {
      case PasswordValidationError.empty:
        return 'Le mot de passe est requis';
      case PasswordValidationError.tooShort:
        return 'Le mot de passe doit contenir au moins 6 caractères';
    }
  }
}


// === Confirm Password ===
enum ConfirmPasswordValidationError { empty, mismatch }

class ConfirmPasswordInput extends FormzInput<String, ConfirmPasswordValidationError> {

  final String password;
  const ConfirmPasswordInput.pure({this.password = ''}) : super.pure('');

  const ConfirmPasswordInput.dirty({
    this.password = '',
    String confirmPassword = '',
  }) : super.dirty(confirmPassword);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) return ConfirmPasswordValidationError.empty;
    if (value != password) return ConfirmPasswordValidationError.mismatch;
    return null;
  }

  ConfirmPasswordInput copyWith({String? value, String? password}) {
    return ConfirmPasswordInput.dirty(
      confirmPassword: value ?? this.value,
      password: password ?? this.password,
    );
  }
}

extension ConfirmPasswordValidationErrorExtension on ConfirmPasswordValidationError {
  String get message {
    switch (this) {
      case ConfirmPasswordValidationError.empty:
        return 'La confirmation du mot de passe est requise';
      case ConfirmPasswordValidationError.mismatch:
        return 'Les mots de passe ne correspondent pas';
    }
  }
}


// === Phone ===
enum MobileValidationError { empty, invalid, badPrefix}

class MobileInput extends FormzInput<String, MobileValidationError> {

  const MobileInput.pure([super.value = '']) : super.pure();
  const MobileInput.dirty([super.value = '']) : super.dirty();

  @override
  MobileValidationError? validator(String value) {

    final cleanValue = value.replaceAll(' ', '');

    if (cleanValue.isEmpty) return MobileValidationError.empty;

    // Longueur incorrecte
    if (cleanValue.length < 10) return MobileValidationError.invalid;

    // Doit être numérique
    if (!RegExp(r'^[0-9]+$').hasMatch(cleanValue)) {
      return MobileValidationError.invalid;
    }

    // Préfixe incorrect
    const validPrefixes = ["01", "05", "07"];
    final isValidPrefix = validPrefixes.any(cleanValue.startsWith);

    if (!isValidPrefix) return MobileValidationError.badPrefix;

    return null;
  }
}

extension PhoneValidationErrorExtension on MobileValidationError {
  String get message {
    switch (this) {
      case MobileValidationError.empty:
        return 'Le numéro de téléphone est requis';
      case MobileValidationError.invalid:
        return 'Le numéro doit être composé de 10 chiffres';
      case MobileValidationError.badPrefix:
        return "Le numéro doit commencer par 01, 05 ou 07.";
    }
  }
}


// === Code OTP ===
enum EnteredOtpValidationError { empty, tooShort }

class EnteredOtpInput extends FormzInput<String, EnteredOtpValidationError> {

  const EnteredOtpInput.pure([super.value = '']) : super.pure();
  const EnteredOtpInput.dirty([super.value = '']) : super.dirty();

  @override
  EnteredOtpValidationError? validator(String value) {
    if (value.isEmpty) return EnteredOtpValidationError.empty;
    if (value.length < 6) return EnteredOtpValidationError.tooShort;
    return null;
  }
}

extension EnteredOtpValidationErrorExtension on EnteredOtpValidationError {
  String get message {
    switch (this) {
      case EnteredOtpValidationError.empty:
        return 'Le code OTP est requis';
      case EnteredOtpValidationError.tooShort:
        return 'Le code OTP doit contenir au moins 4 caractères';
    }
  }
}



enum SecureStringValidationError { empty }


class SecureStringInput extends FormzInput<String, SecureStringValidationError> {

  const SecureStringInput.pure([super.value = '']) : super.pure();
  const SecureStringInput.dirty([super.value = '']) : super.dirty();

  @override
  SecureStringValidationError? validator(String value) {
    if (value.isEmpty) {
      return SecureStringValidationError.empty;
    }
    return null;
  }
}


extension SecureStringValidationErrorExtension on SecureStringValidationError {
  String get message {
    switch (this) {
      case SecureStringValidationError.empty:
        return 'La valeur est requise';
    }
  }
}

