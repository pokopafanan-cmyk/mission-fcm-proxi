import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/domain/entities/user.dart';
import '../../../../core/common/domain/services/password_hasher.dart';
import '../../../../core/common/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';


/// UseCase pour authentifier un utilisateur via login et mot de passe
class SignIn implements UseCase<User, SignInParams> {

  /// Repository d’accès aux opérations d’authentification
  final AuthRepository authRepository;

  /// Service chargé de préparer le mot de passe (GDS + hash)
  final PasswordHasher passwordHasher;


  SignIn({
    required this.authRepository,
    required this.passwordHasher,
  });

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {

    // Préparation du mot de passe (récupération du GDS + hash)
    final hashedPassword = await passwordHasher.preparePassword(login: params.login, rawPassword: params.password);

    return await hashedPassword.fold(
      // Échec lors de la préparation du mot de passe
      (failure) => Left(failure),

      // Authentification avec le mot de passe hashé
      (hashedPassword) async {
        // Transformation du GDS en mot de passe hashé
        return await authRepository.signInWithLoginPassword(login: params.login, password: hashedPassword,);
      },
    );
  }
}

/// Paramètres nécessaires pour la connexion par login/mot de passe
class SignInParams extends Equatable {

  /// Identifiant de l'utilisateur
  final String login;

  /// Mot de passe de l'utilisateur
  final String password;

  const SignInParams({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];
}
