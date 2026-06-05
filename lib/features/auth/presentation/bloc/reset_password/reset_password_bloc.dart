import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/formz/app_formz_fields.dart';
import 'package:formz/formz.dart';
import '../../../domain/usecases/reset_password.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

/// Bloc gérant le formulaire de réinitialisation de mot de passe et ses interactions
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {

  /// UseCase pour réinitialisation le mot de passe
  final ResetPassword resetPassword;

  ResetPasswordBloc({required this.resetPassword}) : super(const ResetPasswordState()) {
    // Événements liés au changement de saisie
    on<ResetPasswordUserKeyChanged>(_onResetPasswordUserKeyChanged);
    on<ResetPasswordChanged>(_onResetPasswordChanged);
    on<ResetConfirmPasswordChanged>(_onResetConfirmPasswordChanged);

    // Événements liés à l'API
    on<ResetPasswordSubmitted>(_onResetPasswordSubmitted);
  }

  /// Mise à jour du champ userKey
  void _onResetPasswordUserKeyChanged(ResetPasswordUserKeyChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(userKey: SecureStringInput.dirty(event.userKey)));
  }

  /// Mise à jour du champ mot de passe
  void _onResetPasswordChanged(ResetPasswordChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(password: PasswordInput.dirty(event.password)));
  }

  /// Mise à jour du champ confirmation mot de passe
  void _onResetConfirmPasswordChanged(ResetConfirmPasswordChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(confirmPassword: ConfirmPasswordInput.dirty(
      password: state.password.value,
      confirmPassword: event.confirmPassword,
    )));
  }

  /// Soumission du formulaire
  Future<void> _onResetPasswordSubmitted(ResetPasswordSubmitted event, Emitter<ResetPasswordState> emit) async {

    // Vérifie la validité du formulaire via Formz
    if (!state.isValid) {
      emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: _firstErrorMessage(state),
      ));
      return;
    }

    // Déclenche le loader
    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));

    // Appel du UseCase de réinitialisation
    final res = await resetPassword(
      ResetPasswordParams(
        userKey: state.userKey.value,
        password: state.password.value,
      ),
    );

    // Gestion du résultat
    res.fold(
      (authFailure) => emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: authFailure.message,
      )),
      (success) => _emitSignUpSuccess(emit),
    );
  }

  /// Émet le state succès après la réinitialisation du mot de passe et reset du formulaire
  void _emitSignUpSuccess(Emitter<ResetPasswordState> emit,) async {
    emit(state.copyWith(
      submissionStatus: FormzSubmissionStatus.success,
      message: 'Mot de passe réinitialisé avec succès',
      userKey: SecureStringInput.pure(),
      password: PasswordInput.pure(),
      confirmPassword: ConfirmPasswordInput.pure(),
    ));
  }

  /// Retourne le premier message d'erreur rencontré dans le formulaire
  String _firstErrorMessage(ResetPasswordState state) {
    for (final input in state.inputs) {
      if (input.isNotValid && input.error != null) {
        return switch (input.error!) {
          SecureStringValidationError e    => e.message,
          PasswordValidationError e        => e.message,
          ConfirmPasswordValidationError e => e.message,
          _ => "Champs invalide",
        };
      }
    }
    return "Informations invalides";
  }
}

