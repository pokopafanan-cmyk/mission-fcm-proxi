import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/common/domain/entities/user.dart';
import '../../../core/common/domain/services/auth_service.dart';
import '../../../core/common/domain/usecases/usecase.dart';
import '../../../core/config/enums.dart';
import '../../../core/events/auth_bus_event.dart';
import '../../../core/events/auth_events.dart';
import '../../../core/utils/app_logger.dart';
import '../../../features/auth/domain/usecases/get_current_user.dart';
import '../../../features/auth/domain/usecases/logout_request.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Bloc gérant l'état et les événements d'authentification
class AuthBloc extends Bloc<AuthEvent, AuthState> {

  /// UseCase pour récupérer l'utilisateur courant
  // final GetCurrentUser getCurrentUser;

  /// Service métier d’authentification (couche domain)
  final AuthService authService;

  /// UseCase pour déconnecter l'utilisateur
  // final LogoutRequest logoutRequest;

  /// Écouteur des événements globaux (ex : ForceLogout)
  late final StreamSubscription _authEventSub;

  AuthBloc({/* required this.getCurrentUser, required this.logoutRequest,*/ required this.authService}) : super(AuthInitial()) {
    // Enregistrement des handlers pour chaque type d'événement
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthUserAuthenticated>(_onAuthUserAuthenticated);
    on<AuthUserUpdated>(_onAuthUserUpdated);
    on<AuthUserLogout>(_onAuthUserLogout);

    // Log de tous les changements de state
    stream.listen((state) {
      AppLogger.info("STATE CHANGE: $state");
    });

    // Écoute le bus global pour les événements critiques
    _authEventSub = GlobalAuthEventBus.stream.listen((event) {
      if (event is ForceLogoutEvent) {
        add(AuthUserLogout(LogoutReason.serverForced));
      }
    });
  }

  /// Vérifie l'état d'authentification au démarrage de l'application
  Future<void> _onCheckStatus(AuthCheckStatus event, Emitter<AuthState> emit,) async {
    emit(AuthLoading());

    // Récupération de l'utilisateur courant
    // final res = await getCurrentUser(NoParams());
    final res = await authService.getCurrentUser();

    res.fold(
      (authFailure) => emit(AuthUnauthenticated(message: authFailure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  /// Déclenché lorsqu'un utilisateur se connecte ou que son profil change
  void _onAuthUserAuthenticated(AuthUserAuthenticated event, Emitter<AuthState> emit,) {
    _updateAuthenticatedUser(event.user, emit);
  }

  /// Déconnecte l'utilisateur
  Future<void> _onAuthUserLogout(AuthUserLogout event, Emitter<AuthState> emit,) async {
    if (state is! AuthAuthenticated) return;

    emit(AuthLoggingOut(message: 'Déconnexion en cours...'));

    // Appel de l'API de déconnexion
    // final res = await logoutRequest(NoParams());
    final res = await authService.logout(reason: event.reason);
    res.fold(
      (authFailure) => emit(AuthFailure(authFailure.message)),
      (success) => emit(AuthUnauthenticated(message: 'Déconnexion effectuée avec succès')),
    );
  }

  /// Met à jour les informations de l'utilisateur
  void _onAuthUserUpdated(AuthUserUpdated event, Emitter<AuthState> emit,) {
    _updateAuthenticatedUser(event.user, emit);
  }

  /// Met à jour le state Authenticated avec les nouvelles informations utilisateur
  Future<void> _updateAuthenticatedUser(User user, Emitter<AuthState> emit) async {
    // On met à jour l'UI
    emit(AuthAuthenticated(user: user));

    // On tente la sauvegarde en arrière-plan
    final res = await authService.saveUser(user: user);

    res.fold(
      (failure) {
        // Log pour le debug
        AppLogger.error("Erreur de sauvegarde : ${failure.message}");
      },
      (success) {},
    );
  }

  @override
  Future<void> close() {
    // Annule l'écouteur global pour éviter les fuites mémoire
    _authEventSub.cancel();
    return super.close();
  }

}
