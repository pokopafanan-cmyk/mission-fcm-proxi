import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/entities/user.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

/// UseCase pour vérifier le code OTP reçu par l'utilisateur
class VerifyOtpCode implements UseCase<User, VerifyOtpCodeParams> {

  /// Dépendance sur le repository d'authentification
  final AuthRepository authRepository;

  VerifyOtpCode({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(VerifyOtpCodeParams params) async {
    /// Appelle le repository pour vérifier le code OTP et récupérer l'utilisateur
    return await authRepository.verifyOtpCode(
      mobile: params.mobile,
      otp: params.otp,
    );
  }
}

/// Paramètres nécessaires pour la vérification du code OTP
class VerifyOtpCodeParams extends Equatable {

  /// Numéro de téléphone de l'utilisateur
  final String mobile;

  /// Code OTP reçu par SMS
  final String otp;

  const VerifyOtpCodeParams({
    required this.mobile,
    required this.otp
  });

  @override
  List<Object?> get props => [mobile, otp];
}
