import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../app/authentication/bloc/auth_bloc.dart';
import '../../../../../core/common/domain/entities/user.dart';
import '../../../../../core/common/formz/app_formz_fields.dart';
import '../../../domain/usecases/request_otp_code.dart';
import '../../../domain/usecases/verify_otp_code.dart';

part 'signin2_event.dart';
part 'signin2_state.dart';


/// Bloc gérant la connexion via OTP (2 étapes)
class SignIn2Bloc extends Bloc<SignIn2Event, SignIn2State> {

  final AuthBloc authBloc; // Bloc global d'authentification
  final RequestOtpCode requestOtpCode; // UseCase pour demander un OTP
  final VerifyOtpCode verifyOtpCode; // UseCase pour vérifier le code OTP

  Timer? _otpTimer;

  SignIn2Bloc({
    required this.verifyOtpCode,
    required this.requestOtpCode,
    required this.authBloc,
  }) : super(const SignIn2State()) {
    // Événements liés au changement de saisie
    on<SignInMobileChanged>(_onSignInMobileChanged);
    on<SignInEnteredOtpChanged>(_onSignInEnteredOtpChanged);

    // Événements liés à l'API
    on<SignInRequestOtp>(_onSignInRequestOtp);
    on<SignInVerifyOtp>(_onSignInVerifyOtp);
  }

  /// Mise à jour du numéro de mobile saisi
  void _onSignInMobileChanged(SignInMobileChanged event, Emitter<SignIn2State> emit) {
    emit(state.copyWith(mobile: MobileInput.dirty(event.mobile.replaceAll(' ', '')),));
  }

  /// Mise à jour du code OTP saisi
  void _onSignInEnteredOtpChanged(SignInEnteredOtpChanged event, Emitter<SignIn2State> emit) {
    emit(state.copyWith(otp: EnteredOtpInput.dirty(event.otp),));
  }

  /// Demande d'envoi ou de renvoi du code OTP
  Future<void> _onSignInRequestOtp(SignInRequestOtp event, Emitter<SignIn2State> emit) async {

    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.initial));

    if (!state.mobile.isValid) {
      emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: _firstErrorMessage(state),
      ));
      return;
    }

    // if (state.userTime > 0) {
    //   emit(state.copyWith(
    //     submissionStatus: FormzSubmissionStatus.failure,
    //     message: "Veuillez patienter ${state.userTime}s avant de renvoyer le code",
    //   ));
    //   return;
    // }

    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));

    final res = await requestOtpCode(RequestOtpCodeParams(mobile: "225${state.mobile.value}"));
    res.fold(
      (failure) => emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: failure.message,
        isResend: false,
      )),
      (otpData) {
        // _startOtpTimer(otpData.waitTime, emit);
        emit(state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
          userTime: otpData.userTime,
          tryCount: otpData.tryCount,
          isResend: true,
          message: "Code OTP envoyé avec succès",
        ));
      },
    );
  }

  /// Vérification du code OTP auprès de l'API
  Future<void> _onSignInVerifyOtp(SignInVerifyOtp event, Emitter<SignIn2State> emit) async {

    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.initial));

    if (!state.otp.isValid) {
      emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: _firstErrorMessage(state),
      ));
      return;
    }

    // if (state.tryCount <= 0) {
    //   emit(state.copyWith(
    //     submissionStatus: FormzSubmissionStatus.failure,
    //     message: "Nombre de tentatives épuisé. Veuillez renvoyer un nouveau code OTP.",
    //   ));
    //   return;
    // }

    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));

    final res = await verifyOtpCode(
      VerifyOtpCodeParams(
        mobile: "225${state.mobile.value}",
        otp: state.otp.value,
      ),
    );

    res.fold(
      (failure) => emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        tryCount: state.tryCount - 1,
        message: state.tryCount - 1 <= 0 ? "Nombre de tentatives épuisé. Veuillez renvoyer un nouveau code OTP." : failure.message,
      )),
      (user) => _emitVerifySuccess(user, emit),
    );
  }


  /// Succès de la vérification du code OTP : notifier le AuthBloc
  void _emitVerifySuccess(User user, Emitter<SignIn2State> emit) {
    authBloc.add(AuthUserAuthenticated(user));
    emit(state.copyWith(
      submissionStatus: FormzSubmissionStatus.success,
      otp: EnteredOtpInput.pure(),
      mobile: MobileInput.pure(),
      isResend: false,
      message: "Connexion effectuée avec succès",
    ));
  }

  /// Timer pour le waitTime avant renvoi du code OTP
  void _startOtpTimer(int seconds, Emitter<SignIn2State> emit) {
    _otpTimer?.cancel();
    int timeLeft = seconds;

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft--;
      emit(state.copyWith(userTime: timeLeft));
      if (timeLeft <= 0) timer.cancel();
    });
  }


  /// Renvoie le premier message d'erreur Formz
  String _firstErrorMessage(SignIn2State state) {
    for (final input in state.inputs) {
      if (!input.isValid && input.error != null) {
        final err = input.error;
        return switch (err) {
          MobileValidationError() => err.message,
          EnteredOtpValidationError() => err.message,
          _ => "Erreur de validation",
        };
      }
    }
    return "Formulaire invalide";
  }

  @override
  Future<void> close() {
    _otpTimer?.cancel();
    return super.close();
  }
}

