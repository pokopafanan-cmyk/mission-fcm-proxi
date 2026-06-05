import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/entities/user.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

/// UseCase pour persister l'utilisateur
/// Unit est utilisé pour indiquer qu’aucune valeur spécifique n’est retournée.
class PersistUser implements UseCase<Unit, PersistUserParams> {

  /// Dépendance sur le repository d'authentification
  final AuthRepository authRepository;

  PersistUser({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(PersistUserParams params) async {
    // Appelle le repository pour effectuer la déconnexion
    return await authRepository.saveUser(user: params.user);
  }
}


/// Paramètres nécessaires pour sauvegarder l'utilisateur
class PersistUserParams extends Equatable {

  final User user;

  const PersistUserParams({required this.user});

  @override
  List<Object> get props => [user];
}