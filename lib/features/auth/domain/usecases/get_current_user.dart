import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/entities/user.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

/// UseCase pour récupérer l'utilisateur actuellement connecté
class GetCurrentUser implements UseCase<User, NoParams> {

  /// Dépendance sur le repository d'authentification
  final AuthRepository authRepository;

  GetCurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(NoParams noParams) async {
    /// Appelle le repository pour obtenir l'utilisateur courant
    return await authRepository.getCurrentUser();
  }
}

