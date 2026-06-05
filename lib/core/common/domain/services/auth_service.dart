import 'package:fpdart/fpdart.dart';
import '../../../config/enums.dart';
import '../../../error/failure.dart';
import '../entities/user.dart';

/// Contrat du service d’authentification (couche domain)
///
/// Définit les opérations liées à l’état d’authentification
/// de l’utilisateur, indépendamment de toute implémentation.
abstract interface class AuthService {

  /// Récupère l’utilisateur actuellement authentifié.
  Future<Either<Failure, User>> getCurrentUser();

  /// Déconnecte l’utilisateur courant.
  /// Invalide la session locale et/ou distante selon l’implémentation.
  /// Ne retourne aucune donnée métier.
  Future<Either<Failure, Unit>> logout({required LogoutReason reason});

  /// Persister les infos du user connecté
  Future<Either<Failure, Unit>> saveUser({required User user});
}
