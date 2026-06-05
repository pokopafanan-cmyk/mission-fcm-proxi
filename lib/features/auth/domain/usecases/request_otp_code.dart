import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/otp_data.dart';
import '../repositories/auth_repository.dart';

/// UseCase pour demander un code OTP pour un numéro de mobile
class RequestOtpCode implements UseCase<OtpData, RequestOtpCodeParams> {

  /// Dépendance sur le repository d'authentification
  final AuthRepository authRepository;

  RequestOtpCode({required this.authRepository});

  @override
  Future<Either<Failure, OtpData>> call(RequestOtpCodeParams params) async {
    /// Appelle le repository pour envoyer le code OTP au mobile
    return await authRepository.requestOtpCode(mobile: params.mobile);
  }
}

/// Paramètres nécessaires pour demander un OTP
class RequestOtpCodeParams extends Equatable {

  /// Numéro de téléphone de l'utilisateur
  final String mobile;

  const RequestOtpCodeParams({required this.mobile});

  @override
  List<Object?> get props => [mobile];
}
