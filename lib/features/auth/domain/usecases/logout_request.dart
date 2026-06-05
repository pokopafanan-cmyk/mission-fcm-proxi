import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/config/enums.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

/// UseCase pour déconnecter l'utilisateur
/// Unit est utilisé pour indiquer qu’aucune valeur spécifique n’est retournée.
class LogoutRequest implements UseCase<Unit, LogoutRequestParams> {

  /// Dépendance sur le repository d'authentification
  final AuthRepository authRepository;

  LogoutRequest({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(LogoutRequestParams params) async {
    // Appelle le repository pour effectuer la déconnexion
    return await authRepository.logout(reason: params.reason);
  }
}


/// Paramètres nécessaires pour demander un OTP
class LogoutRequestParams extends Equatable {

  /// Raison de la deconnexion de l'utilisateur
  final LogoutReason reason;

  const LogoutRequestParams({required this.reason});

  @override
  List<Object> get props => [reason];
}

