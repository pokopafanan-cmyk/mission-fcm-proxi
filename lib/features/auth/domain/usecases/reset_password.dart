import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/services/password_hasher.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';


/// UseCase pour demander la réinitialisation du mot de passe
/// Unit est utilisé pour indiquer qu’aucune valeur spécifique n’est retournée.
class ResetPassword implements UseCase<Unit, ResetPasswordParams> {

  /// Dépendance sur le repository d'authentification
  final AuthRepository authRepository;

  /// Service chargé de préparer le mot de passe (GDS + hash)
  final PasswordHasher passwordHasher;

  ResetPassword({
    required this.authRepository,
    required this.passwordHasher,
  });

  @override
  Future<Either<Failure, Unit>> call(ResetPasswordParams params) async {

    // Hash du nouveau mot de passe avec un nouveau GDS
    final (newGds, newPasswordHashed) = passwordHasher.hashPassword(rawPassword: params.password);

    /// Appelle la méthode du repository pour la réinitialisation du mot de passe
    return await authRepository.resetPassword(userKey: params.userKey, password: newPasswordHashed, gds: newGds);
  }
}

/// Paramètres nécessaires pour la réinitialisation du mot de passe
class ResetPasswordParams extends Equatable {

  /// Email de l'utilisateur
  final String userKey;
  final String password;

  const ResetPasswordParams({
    required this.userKey,
    required this.password,
  });

  @override
  List<Object> get props => [userKey, password];
}
