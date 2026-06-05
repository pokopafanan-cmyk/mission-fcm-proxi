import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/common/formz/app_formz_fields.dart';
import '../../../domain/usecases/request_password_reset.dart';

part 'request_password_reset_event.dart';
part 'request_password_reset_state.dart';

/// Bloc gérant le formulaire de demande de réinitialisation de mot de passe et ses interactions
class RequestPasswordResetBloc extends Bloc<RequestPasswordResetEvent, RequestPasswordResetState> {

  /// Use case chargé d’exécuter la demande de mot de passe oublié
  final RequestPasswordReset requestPasswordReset;

  RequestPasswordResetBloc({required this.requestPasswordReset}) : super(const RequestPasswordResetState()) {

    /// Écoute les changements du champ email
    on<RequestPasswordResetEmailChanged>(_onForgotPasswordEmailChanged);

    /// Soumission du formulaire de mot de passe oublié
    on<RequestPasswordResetSubmitted>(_onForgotPasswordSubmitted);
  }

  /// Met à jour l’email saisi par l’utilisateur avec validation Formz
  void _onForgotPasswordEmailChanged(RequestPasswordResetEmailChanged event, Emitter<RequestPasswordResetState> emit,) {
    emit(state.copyWith(email: EmailInput.dirty(event.email)));
  }

  /// Gère la soumission du formulaire "mot de passe oublié"
  Future<void> _onForgotPasswordSubmitted(RequestPasswordResetSubmitted event, Emitter<RequestPasswordResetState> emit,) async {

    /// Vérifie la validité du formulaire
    if (!state.isValid) {
      emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: _firstErrorMessage(state),
      ));
      return;
    }

    /// Affiche l’état de chargement
    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));

    /// Appel du use case de réinitialisation du mot de passe
    final res = await requestPasswordReset(
      RequestPasswordResetParams(email: state.email.value),
    );

    /// Gestion du résultat (succès ou erreur)
    res.fold(
      (failure) => emit(
        state.copyWith(
          submissionStatus: FormzSubmissionStatus.failure,
          message: failure.message,
        ),
      ),
      (success) => emit(
        state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
          email: EmailInput.pure(),
          message: 'Demande de réinitialisation traitée avec succès',
        ),
      ),
    );
  }

  /// Retourne le premier message d’erreur de validation rencontré
  String _firstErrorMessage(RequestPasswordResetState state) {
    for (final input in state.inputs) {
      if (input.isNotValid && input.error != null) {
        final err = input.error;
        return switch (err) {
          EmailValidationError() => err.message,
          _ => "Erreur de validation",
        };
      }
    }
    return "Formulaire invalide";
  }
}
