import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/entities/user.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/profile_repository.dart';

/// UseCase pour modifier les infos d'un utilisateur
class UpdateUser implements UseCase<User, UpdateUserParams> {

  /// Repository des opérations liées au profil utilisateur
  final ProfileRepository profileRepository;

  UpdateUser({required this.profileRepository});

  @override
  Future<Either<Failure, User>> call(UpdateUserParams params) async {

    /// Appelle le repository pour modifier le compte
    return await profileRepository.updateUser(
      login: params.login,
      nom: params.nom,
      prenoms: params.prenoms,
      email: params.email,
      mobile: params.mobile,
    );
  }
}

/// Paramètres nécessaires pour modifier un compte
class UpdateUserParams extends Equatable {

  final String login;
  final String nom;
  final String prenoms;
  final String email;
  final String mobile;

  const UpdateUserParams({
    required this.login,
    required this.nom,
    required this.prenoms,
    required this.email,
    required this.mobile,
  });

  @override
  List<Object> get props => [login, nom, prenoms, email, mobile];
}
