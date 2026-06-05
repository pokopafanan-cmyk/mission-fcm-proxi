import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/services/password_hasher.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/profile_repository.dart';

/// Use case chargé de modifier le mot de passe d’un utilisateur
class ChangePassword implements UseCase<Unit, ChangePasswordParams> {

  /// Repository des opérations liées au profil utilisateur
  final ProfileRepository profileRepository;

  /// Service chargé de préparer le mot de passe (GDS + hash)
  final PasswordHasher passwordHasher;

  ChangePassword({
    required this.profileRepository,
    required this.passwordHasher,
  });

  @override
  Future<Either<Failure, Unit>> call(ChangePasswordParams params) async {

    // Préparation de l’ancien mot de passe (GDS + hash)
    final gdsResult = await passwordHasher.preparePassword(
      login: params.login,
      rawPassword: params.oldPassword,
    );

    return gdsResult.fold(
      // Échec lors de la préparation du mot de passe
      (failure) => Left(failure),

      (oldPasswordHashed) async {
        
        // Hash du nouveau mot de passe avec un nouveau GDS
        final (newGds, newPasswordHashed) = passwordHasher.hashPassword(rawPassword: params.newPassword);

        // Mise à jour du mot de passe via le repository
        return await profileRepository.changePassword(login: params.login, oldPassword: oldPasswordHashed, newPassword: newPasswordHashed, gds: newGds);
      },
    );
  }
}




/// Paramètres nécessaires pour la modification du mot de passe
class ChangePasswordParams extends Equatable {

  /// Identifiant de l'utilisateur
  final String login;

  /// Nouveau Mot de passe de l'utilisateur
  final String newPassword;

  /// Ancien Mot de passe de l'utilisateur
  final String oldPassword;

  const ChangePasswordParams({
    required this.login,
    required this.newPassword,
    required this.oldPassword,
  });

  @override
  List<Object> get props => [login, newPassword, oldPassword];
}