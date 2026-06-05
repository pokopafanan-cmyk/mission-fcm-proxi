part of 'signin2_bloc.dart';

/// Événements pour la deuxième étape de connexion (OTP)
sealed class SignIn2Event extends Equatable {
  const SignIn2Event();
}

/// Changement du numéro de téléphone saisi par l'utilisateur
final class SignInMobileChanged extends SignIn2Event {

  final String mobile;
  const SignInMobileChanged(this.mobile);

  @override
  List<Object> get props => [mobile];
}

/// Changement du code OTP saisi par l'utilisateur
final class SignInEnteredOtpChanged extends SignIn2Event {
  final String otp;
  const SignInEnteredOtpChanged(this.otp);

  @override
  List<Object> get props => [otp];
}

/// Vérification du code OTP auprès de l'API
final class SignInVerifyOtp extends SignIn2Event {
  @override
  List<Object> get props => [];
}

/// Demande d'envoi ou de renvoi du code OTP
final class SignInRequestOtp extends SignIn2Event {
  @override
  List<Object> get props => [];
}


/// Soumission du formulaire code OTP (validation)
// final class SignInSubmitted extends SignIn2Event {
//   @override
//   List<Object> get props => [];
// }
