import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/authentication/bloc/auth_bloc.dart';
import '../../../../../core/common/formz/app_formz_fields.dart';
import 'package:formz/formz.dart';
import '../../../domain/usecases/sign_up.dart';

part 'signup_event.dart';
part 'signup_state.dart';

/// Bloc gérant le formulaire d'inscription et ses interactions
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {

  /// UseCase pour inscrire un utilisateur
  final SignUp signUp;

  SignUpBloc({required this.signUp}) : super(const SignUpState()) {
    // Événements liés au changement de saisie
    on<SignUpLoginChanged>(_onSignUpLoginChanged);
    on<SignUpNomChanged>(_onSignUpNomChanged);
    on<SignUpPrenomsChanged>(_onSignUpPrenomsChanged);
    on<SignUpEmailChanged>(_onSignUpEmailChanged);
    on<SignUpPasswordChanged>(_onSignUpPasswordChanged);
    on<SignUpConfirmPasswordChanged>(_onSignUpConfirmPasswordChanged);
    on<SignUpMobileChanged>(_onSignUpMobileChanged);

    // Événements liés à l'API
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  /// Mise à jour du champ login
  void _onSignUpLoginChanged(SignUpLoginChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(login: LoginInput.dirty(event.login)));
  }

  /// Mise à jour du champ nom
  void _onSignUpNomChanged(SignUpNomChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(nom: NomInput.dirty(event.nom)));
  }

  /// Mise à jour du champ prénoms
  void _onSignUpPrenomsChanged(SignUpPrenomsChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(prenoms: PrenomsInput.dirty(event.prenoms)));
  }

  /// Mise à jour du champ email
  void _onSignUpEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: EmailInput.dirty(event.email)));
  }

  /// Mise à jour du champ mot de passe
  void _onSignUpPasswordChanged(SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: PasswordInput.dirty(event.password)));
  }

  /// Mise à jour du champ confirmation mot de passe
  void _onSignUpConfirmPasswordChanged(SignUpConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(confirmPassword: ConfirmPasswordInput.dirty(
      password: state.password.value,
      confirmPassword: event.confirmPassword,
    )));
  }

  /// Mise à jour du champ téléphone
  void _onSignUpMobileChanged(SignUpMobileChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(mobile: MobileInput.dirty(event.mobile.replaceAll(' ', ''))));
  }

  /// Soumission du formulaire
  Future<void> _onSignUpSubmitted(SignUpSubmitted event, Emitter<SignUpState> emit) async {

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

    // Appel du UseCase d'inscription
    final res = await signUp(
      SignUpParams(
        login: state.login.value,
        nom: state.nom.value,
        prenoms: state.prenoms.value,
        email: state.email.value,
        password: state.password.value,
        mobile: "225${state.mobile.value}",
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

  /// Émet le state succès après inscription et reset du formulaire
  void _emitSignUpSuccess(Emitter<SignUpState> emit,) async {
    emit(state.copyWith(
      submissionStatus: FormzSubmissionStatus.success,
      message: 'Inscription effectuée avec succès',
      login: LoginInput.pure(),
      nom: NomInput.pure(),
      prenoms: PrenomsInput.pure(),
      email: EmailInput.pure(),
      password: PasswordInput.pure(),
      confirmPassword: ConfirmPasswordInput.pure(),
      mobile: MobileInput.pure(),
    ));
  }

  /// Retourne le premier message d'erreur rencontré dans le formulaire
  String _firstErrorMessage(SignUpState state) {
    for (final input in state.inputs) {
      if (input.isNotValid && input.error != null) {
        return switch (input.error!) {
          LoginValidationError e           => e.message,
          NomValidationError e             => e.message,
          PrenomsValidationError e         => e.message,
          EmailValidationError e           => e.message,
          PasswordValidationError e        => e.message,
          ConfirmPasswordValidationError e => e.message,
          MobileValidationError e           => e.message,
          _ => "Champs invalide",
        };
      }
    }
    return "Informations invalides";
  }
}

