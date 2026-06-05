import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/entities/user.dart';
import '../../../../core/common/domain/services/auth_service.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/config/enums.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/logout_request.dart';
import '../../domain/usecases/persist_user.dart';

/// Implémentation du service d’authentification (couche domain)
/// Elle délègue les actions aux cas d’usage correspondants.
class AuthServiceImpl implements AuthService {

  /// Cas d’usage permettant de récupérer l’utilisateur connecté
  final GetCurrentUser _getCurrentUser;

  /// Cas d’usage permettant de déconnecter l’utilisateur
  final LogoutRequest _logoutRequest;

  /// Cas d’usage permettant de sauvegarder l’utilisateur
  final PersistUser _persistUser;

  AuthServiceImpl({
    required GetCurrentUser getCurrentUser,
    required LogoutRequest logoutRequest,
    required PersistUser persistUser,
  })  : _getCurrentUser = getCurrentUser,
        _logoutRequest = logoutRequest,
        _persistUser = persistUser;

  /// Retourne l’utilisateur actuellement authentifié s’il existe
  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    return await _getCurrentUser(NoParams());
  }

  /// Déconnecte l’utilisateur courant et invalide la session
  @override
  Future<Either<Failure, Unit>> logout({required LogoutReason reason}) async {
    return await _logoutRequest(LogoutRequestParams(reason: reason));
  }

  /// Persister les infos du user connecté
  @override
  Future<Either<Failure, Unit>> saveUser({required User user}) async {
    return await _persistUser(PersistUserParams(user: user));
  }
}
