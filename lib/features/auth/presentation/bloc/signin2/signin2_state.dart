part of 'signin2_bloc.dart';

/// State pour la deuxième étape de connexion (OTP) avec Formz pour la validation
class SignIn2State extends Equatable with FormzMixin {

  /// Temps d'attente avant de pouvoir renvoyer un OTP (en secondes)
  final int userTime;

  /// Nombre de tentatives restantes pour saisir le OTP
  final int tryCount;

  /// Indique si c'est une tentative de renvoi de OTP
  final bool isResend;

  /// Numéro de mobile saisi par l'utilisateur
  final MobileInput mobile;

  /// OTP saisi par l'utilisateur
  final EnteredOtpInput otp;

  /// Statut de soumission du formulaire (initial, inProgress, success, failure)
  final FormzSubmissionStatus submissionStatus;

  /// Message optionnel d'erreur ou d'information
  final String? message;


  const SignIn2State({
    this.userTime = 0,
    this.tryCount = 0,
    this.isResend = false,
    this.mobile = const MobileInput.pure(),
    this.otp = const EnteredOtpInput.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.message
  });

  /// Crée une nouvelle instance du state en mettant à jour uniquement les champs fournis.
  /// Utilisé par le Bloc pour produire un nouvel état immuable.
  SignIn2State copyWith({
    int? userTime,
    int? tryCount,
    bool? isResend,
    MobileInput? mobile,
    EnteredOtpInput? otp,
    FormzSubmissionStatus? submissionStatus,
    String? message
  }) {
    return SignIn2State(
      userTime: userTime ?? this.userTime,
      tryCount: tryCount ?? this.tryCount,
      isResend: isResend ?? this.isResend,
      mobile: mobile ?? this.mobile,
      otp: otp ?? this.otp,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      message: message ?? this.message,
    );
  }

  /// Le formulaire peut être soumis uniquement si :
  /// - tous les champs sont valides (Formz)
  /// - aucune soumission n'est en cours
  bool get canRequestOtp => mobile.isValid && !submissionStatus.isInProgress;

  bool get canVerifyOtp => otp.isValid && !submissionStatus.isInProgress;

  /// Propriétés utilisées pour comparer deux états (Equatable)
  @override
  List<Object?> get props => [userTime, tryCount, mobile, otp, submissionStatus, message];

  /// Inputs utilisés pour la validation Formz
  @override
  List<FormzInput> get inputs => [mobile, otp];
}
