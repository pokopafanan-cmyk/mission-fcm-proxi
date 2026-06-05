import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/entities/user.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/profile_repository.dart';

/// UseCase pour récupérer les utilisateurs
class GetUsers implements UseCase<List<User>, GetUsersParams> {

  /// Repository des opérations liées au profil utilisateur
  final ProfileRepository profileRepository;

  GetUsers({required this.profileRepository});

  @override
  Future<Either<Failure, List<User>>> call(GetUsersParams params) async {

    /// Appelle le repository pour récupérer les utilisateurs
    return await profileRepository.getUsers(page: params.page, limit: params.limit,);
  }
}

/// Paramètres nécessaires pour la récupéreration des utilisateurs
class GetUsersParams extends Equatable {

  final int page;
  final int limit;

  const GetUsersParams({
    this.page = 1,
    this.limit = 1,
  });

  @override
  List<Object> get props => [page, limit];
}
