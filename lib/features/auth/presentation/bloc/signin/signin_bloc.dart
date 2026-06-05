import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../app/authentication/bloc/auth_bloc.dart';
import '../../../../../core/common/domain/entities/user.dart';
import '../../../../../core/common/formz/app_formz_fields.dart';
import '../../../domain/usecases/sign_in.dart';

part 'signin_event.dart';
part 'signin_state.dart';

/// Bloc gérant le formulaire de connexion et ses interactions
class SignInBloc extends Bloc<SignInEvent, SignInState> {

  /// Use case chargé de gérer la connexion utilisateur (appel au repository)
  final SignIn signIn;

  /// Bloc global d’authentification pour notifier l’état connecté
  final AuthBloc authBloc;

  SignInBloc({
    required this.signIn,
    required this.authBloc,
  }) : super(const SignInState()) {

    /// Écoute les changements du champ login
    on<SignInLoginChanged>(_onSignInLoginChanged);

    /// Écoute les changements du champ mot de passe
    on<SignInPasswordChanged>(_onSignInPasswordChanged);

    /// Soumission du formulaire de connexion
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  /// Met à jour l’état avec la nouvelle valeur du login
  void _onSignInLoginChanged(SignInLoginChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(login: LoginInput.dirty(event.login)));
  }

  /// Met à jour l’état avec la nouvelle valeur du mot de passe
  void _onSignInPasswordChanged(SignInPasswordChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: PasswordInput.dirty(event.password)));
  }

  /// Gère la soumission du formulaire de connexion
  Future<void> _onSignInSubmitted(SignInSubmitted event, Emitter<SignInState> emit) async {

    /// Vérifie la validité des champs via Formz
    if (!state.isValid) {
      emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: _firstErrorMessage(state),
      ));
      return;
    }

    /// Passage de l’état en chargement
    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));

    /// Appel du use case de connexion
    final res = await signIn(
      SignInParams(
        login: state.login.value,
        password: state.password.value,
      ),
    );

    /// Gestion du résultat (échec ou succès)
    res.fold(
      (authFailure) => emit(
        state.copyWith(
          submissionStatus: FormzSubmissionStatus.failure,
          message: authFailure.message,
        ),
      ),
      (user) => _emitSignInSuccess(user, emit),
    );
  }


  /// Gère le succès de la connexion utilisateur
  void _emitSignInSuccess(User user, Emitter<SignInState> emit) async {

    /// Notifie le AuthBloc que l’utilisateur est authentifié
    authBloc.add(AuthUserAuthenticated(user));

    /// Réinitialise le formulaire et indique le succès
    emit(state.copyWith(
      submissionStatus: FormzSubmissionStatus.success,
      message: 'Connexion effectuée avec succès',
      login: LoginInput.pure(),
      password: PasswordInput.pure(),
    ));
  }

  /// Retourne le premier message d’erreur rencontré dans le formulaire
  String _firstErrorMessage(SignInState state) {
    for (final input in state.inputs) {
      if (input.isNotValid && input.error != null) {
        final err = input.error;
        return switch (err) {
          LoginValidationError() => err.message,
          PasswordValidationError() => err.message,
          _ => "Erreur de validation",
        };
      }
    }
    return "Formulaire invalide";
  }
}
