import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

/// UseCase pour demander la réinitialisation du mot de passe
/// Unit est utilisé pour indiquer qu’aucune valeur spécifique n’est retournée.
class RequestPasswordReset implements UseCase<Unit, RequestPasswordResetParams> {

  /// Dépendance sur le repository d'authentification
  final AuthRepository authRepository;

  RequestPasswordReset({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(RequestPasswordResetParams params) async {
    /// Appelle la méthode du repository pour envoyer l'email de réinitialisation
    return await authRepository.requestPasswordReset(email: params.email);
  }
}

/// Paramètres nécessaires pour la réinitialisation du mot de passe
class RequestPasswordResetParams extends Equatable {

  /// Email de l'utilisateur
  final String email;

  const RequestPasswordResetParams({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}
