import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/common/domain/services/password_hasher.dart';

/// UseCase pour créer un nouvel utilisateur
class SignUp implements UseCase<Unit, SignUpParams> {

  /// Dépendance sur le repository d'authentification
  final AuthRepository authRepository;

  /// Service pour hasher le mot de passe
  final PasswordHasher passwordHasher;

  SignUp({required this.authRepository, required this.passwordHasher});

  @override
  Future<Either<Failure, Unit>> call(SignUpParams params) async {

    /// Hash le mot de passe et génère le GDS
    final (gds, password) = passwordHasher.hashPassword(rawPassword: params.password);

    /// Appelle le repository pour créer le compte
    return await authRepository.signUp(
      login: params.login,
      nom: params.nom,
      prenoms: params.prenoms,
      email: params.email,
      mobile: params.mobile,
      hashedPassword: password,
      gds: gds,
    );
  }
}

/// Paramètres nécessaires pour créer un compte
class SignUpParams extends Equatable {

  final String login;
  final String nom;
  final String prenoms;
  final String email;
  final String password;
  final String mobile;

  const SignUpParams({
    required this.login,
    required this.nom,
    required this.prenoms,
    required this.email,
    required this.password,
    required this.mobile,
  });

  @override
  List<Object?> get props => [login, nom, prenoms, email, password, mobile];
}
