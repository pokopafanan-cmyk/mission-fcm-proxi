import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/authentication/bloc/auth_bloc.dart';
import '../../../../../core/common/domain/entities/user.dart';
import 'package:formz/formz.dart';
import '../../../../../core/common/formz/app_formz_fields.dart';
import '../../../domain/usecases/update_user.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

/// Bloc gérant le formulaire de mise à jour des informations du user et ses interactions
class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {

  /// UseCase pour modifier un utilisateur
  final UpdateUser updateUser;

  UpdateUserBloc({required this.updateUser}) : super(const UpdateUserState()) {
    // Événements liés au changement de saisie
    on<UpdateUserLoginChanged>(_onUpdateUserLoginChanged);
    on<UpdateUserNomChanged>(_onUpdateUserNomChanged);
    on<UpdateUserPrenomsChanged>(_onUpdateUserPrenomsChanged);
    on<UpdateUserEmailChanged>(_onUpdateUserEmailChanged);
    on<UpdateUserMobileChanged>(_onUpdateUserMobileChanged);
    on<UpdateUserFormInitialized>(_onUpdateUserFormInitialized);
    // Événements liés à l'API
    on<UpdateUserSubmitted>(_onUpdateUserSubmitted);
  }

  /// Mise à jour du champ login
  void _onUpdateUserLoginChanged(UpdateUserLoginChanged event, Emitter<UpdateUserState> emit) {
    emit(state.copyWith(login: LoginInput.dirty(event.login)));
  }

  /// Mise à jour du champ nom
  void _onUpdateUserNomChanged(UpdateUserNomChanged event, Emitter<UpdateUserState> emit) {
    emit(state.copyWith(nom: NomInput.dirty(event.nom)));
  }

  /// Mise à jour du champ prénoms
  void _onUpdateUserPrenomsChanged(UpdateUserPrenomsChanged event, Emitter<UpdateUserState> emit) {
    emit(state.copyWith(prenoms: PrenomsInput.dirty(event.prenoms)));
  }

  /// Mise à jour du champ email
  void _onUpdateUserEmailChanged(UpdateUserEmailChanged event, Emitter<UpdateUserState> emit) {
    emit(state.copyWith(email: EmailInput.dirty(event.email)));
  }

  /// Mise à jour du champ téléphone
  void _onUpdateUserMobileChanged(UpdateUserMobileChanged event, Emitter<UpdateUserState> emit) {
    emit(state.copyWith(mobile: MobileInput.dirty(event.mobile.replaceAll(' ', ''))));
  }

  /// Handler appelé lors de l'initialisation du formulaire de mise à jour utilisateur.
  void _onUpdateUserFormInitialized(UpdateUserFormInitialized event, Emitter<UpdateUserState> emit,) {
    emit(
      state.copyWith(
        user: event.user,
        login: LoginInput.dirty(event.user.login),
        nom: NomInput.dirty(event.user.nom),
        prenoms: PrenomsInput.dirty(event.user.prenoms),
        email: EmailInput.dirty(event.user.email),
        mobile: MobileInput.dirty(event.user.localMobile),
      ),
    );
  }

  /// Soumission du formulaire
  Future<void> _onUpdateUserSubmitted(UpdateUserSubmitted event, Emitter<UpdateUserState> emit) async {

    // Vérifie la validité du formulaire via Formz
    if (!state.isValid) {
      emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: _firstErrorMessage(state),
      ));
      return;
    }

    // Vérifie la validité du formulaire via Formz
    if (!state.isModified) {
      emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: "Aucune modification détectée",
      ));
      return;
    }

    // Déclenche le loader
    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));

    // Appel du UseCase de modification
    final res = await updateUser(UpdateUserParams(
      login: state.login.value,
      nom: state.nom.value,
      prenoms: state.prenoms.value,
      email: state.email.value,
      mobile: "225${state.mobile.value}",
    ));

    // Gestion du résultat
    res.fold(
      (failure) => emit(state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
        message: failure.message,
      )),
      (user) => _emitUpdateUserSuccess(emit, user),
    );
  }

  /// Émet le state succès après modification et reset du formulaire
  void _emitUpdateUserSuccess(Emitter<UpdateUserState> emit, User user) async {
    emit(state.copyWith(
      user: user,
      submissionStatus: FormzSubmissionStatus.success,
      message: 'Compte modifié avec succès',
    ));
  }

  /// Retourne le premier message d'erreur rencontré dans le formulaire
  String _firstErrorMessage(UpdateUserState state) {
    for (final input in state.inputs) {
      if (input.isNotValid && input.error != null) {
        return switch (input.error!) {
          LoginValidationError e           => e.message,
          NomValidationError e             => e.message,
          PrenomsValidationError e         => e.message,
          EmailValidationError e           => e.message,
          MobileValidationError e           => e.message,
          _ => "Champs invalide",
        };
      }
    }
    return "Informations invalides";
  }

}

