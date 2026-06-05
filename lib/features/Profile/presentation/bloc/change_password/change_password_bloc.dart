import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/common/formz/app_formz_fields.dart';
import '../../../domain/usecases/change_password.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

/// Bloc gérant le formulaire de modification de mot de passe et ses interactions
class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {

  /// UseCase pour modifier pour modifier le mot de passe
  final ChangePassword changePassword;

  ChangePasswordBloc({required this.changePassword}) : super(const ChangePasswordState()) {

    // Événements liés au changement de saisie
    on<ChangeLoginChanged>(_onChangeLoginChanged);
    on<ChangeOldPasswordChanged>(_onChangeOldPasswordChanged);
    on<ChangeNewPasswordChanged>(_onChangeNewPasswordChanged);
    on<ChangeConfirmNewPasswordChanged>(_onChangeConfirmNewPasswordChanged);

    // Événements liés à l'API
    on<ChangePasswordSubmitted>(_onChangePasswordSubmitted);
  }

  /// Mise à jour du champ login
  void _onChangeLoginChanged(ChangeLoginChanged event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(login: LoginInput.dirty(event.login)));
  }

  /// Mise à jour du champ ancien Mot de passe
  void _onChangeOldPasswordChanged(ChangeOldPasswordChanged event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(oldPassword: PasswordInput.dirty(event.oldPassword)));
  }

  /// Mise à jour du champ nouveau mot de passe
  void _onChangeNewPasswordChanged(ChangeNewPasswordChanged event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(newPassword: PasswordInput.dirty(event.newPassword)));
  }

  /// Mise à jour du champ confirmation nouveau mot de passe
  void _onChangeConfirmNewPasswordChanged(ChangeConfirmNewPasswordChanged event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(
      confirmNewPassword: ConfirmPasswordInput.dirty(
        password: state.newPassword.value,
        confirmPassword: event.confirmNewPassword,
      ),
    ));
  }

  /// Soumission du formulaire
  Future<void> _onChangePasswordSubmitted(ChangePasswordSubmitted event, Emitter<ChangePasswordState> emit) async {

    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.initial));

    // Vérifie la validité du formulaire via Formz
    if (!state.isValid) {
      emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: _firstErrorMessage(state),
      ));
      return;
    }

    // Empêche la soumission si le nouveau mot de passe est identique à l’ancien
    final isSame = state.oldPassword.value == state.newPassword.value;

    if (isSame) {
      emit(
        state.copyWith(
          submissionStatus: FormzSubmissionStatus.failure,
          message: 'Veuillez choisir un mot de passe différent de l’ancien.',
        ),
      );
      return;
    }

    // Déclenche le loader
    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));

    // Appel du UseCase d'inscription
    final res = await changePassword(
      ChangePasswordParams(
        login: state.login.value,
        oldPassword: state.oldPassword.value,
        newPassword: state.newPassword.value,
      ),
    );

    // Gestion du résultat
    res.fold(
      (failure) => emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: failure.message,
      )),
      (success) => _emitUpdatePasswordSuccess(emit),
    );
  }

  /// Émet le state succès après modification et reset du formulaire
  void _emitUpdatePasswordSuccess(Emitter<ChangePasswordState> emit,) async {
    emit(state.copyWith(
      submissionStatus: FormzSubmissionStatus.success,
      message: 'Mot de passe a été modifié avec succès.',
      login: LoginInput.pure(),
      oldPassword: PasswordInput.pure(),
      newPassword: PasswordInput.pure(),
      confirmNewPassword: ConfirmPasswordInput.pure(),
    ));
  }

  /// Retourne le premier message d'erreur rencontré dans le formulaire
  String _firstErrorMessage(ChangePasswordState state) {
    for (final input in state.inputs) {
      if (input.isNotValid && input.error != null) {
        return switch (input.error!) {
          LoginValidationError e           => e.message,
          PasswordValidationError e        => e.message,
          ConfirmPasswordValidationError e => e.message,
          _ => "Champs invalide",
        };
      }
    }
    return "Informations invalides";
  }

}

