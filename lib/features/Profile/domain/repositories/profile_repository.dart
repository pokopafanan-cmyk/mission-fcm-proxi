import '../../../../core/common/domain/entities/user.dart';
import '../../../../core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {

  /// Modifier les infos de l’utilisateur
  Future<Either<Failure, User>> updateUser({
    required String login,
    required String nom,
    required String prenoms,
    required String email,
    required String mobile,
  });

  /// Modifier le Mot de passe de l’utilisateur
  Future<Either<Failure, Unit>> changePassword({
    required String login,
    required String newPassword,
    required String oldPassword,
    required String gds,
  });

  /// Récupérer les utilisateurs
  Future<Either<Failure, List<User>>> getUsers({
    required int page,
    required int limit,
  });

}



