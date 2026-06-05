import '../../../../core/common/data/models/user_model.dart';
import '../../../../core/common/domain/entities/user.dart';
import '../../../../core/config/enums.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/otp_data.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_local_data_source.dart';
import '../datasource/auth_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {

  /// Source de données locale (cache, storage sécurisé, session)
  final AuthLocalDataSource localDataSource;

  /// Source de données distante (API, backend)
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Unit>> requestPasswordReset({required String email}) async {
    /// Lance la demande de réinitialisation du mot de passe via l’API
    try {
      final result = await remoteDataSource.requestPasswordReset(email: email);

      if (result.isError) {
        return Left(AuthFailure(result.comment));
      }

      return Right(unit);

    } on NetworkException {
      /// Erreur liée à la connectivité réseau
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      /// Erreur renvoyée par le serveur
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Une erreur inattendue est survenue: $e'));
    }
  }

  @override
  Future<Either<Failure, OtpData>> requestOtpCode({required String mobile}) async {
    /// Demande l’envoi d’un OTP pour un numéro de téléphone
    try {
      final result = await remoteDataSource.requestOtpCode(mobile: mobile);

      if (result.isError) {
        return Left(AuthFailure(result.comment));
      }

      // Vérification de la présence des données
      final data = result.data;
      if (data == null) {
        return const Left(ServerFailure('Données reçues vides ou corrompues'));
      }

      return Right(data.toEntity());

    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Une erreur inattendue est survenue: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithLoginPassword({
    required String login,
    required String password,
  }) async {
    /// Authentifie l’utilisateur avec login et mot de passe
    try {
      final result = await remoteDataSource.signInWithLoginPassword(
        login: login,
        password: password,
      );

      if (result.isError) {
        return Left(AuthFailure(result.comment));
      }

      // Vérification de la présence des données
      final data = result.data;
      if (data == null) {
        return const Left(ServerFailure('Données reçues vides ou corrompues'));
      }

      /// Sauvegarde des informations utilisateur et du token en local
      await localDataSource.saveUser(data);
      await localDataSource.saveAuthToken(data.session!);

      return Right(data.toEntity());

    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Une erreur inattendue est survenue: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp({
    required String login,
    required String nom,
    required String prenoms,
    required String email,
    required String hashedPassword,
    required String mobile,
    required String gds,
  }) async {
    /// Inscription d’un nouvel utilisateur via l’API
    try {
      final result = await remoteDataSource.signUp(
        login: login,
        nom: nom,
        prenoms: prenoms,
        email: email,
        password: hashedPassword,
        mobile: mobile,
        gds: gds,
      );

      if (result.isError) {
        return Left(AuthFailure(result.comment));
      }

      return Right(unit);

    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Une erreur inattendue est survenue: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtpCode({
    required String mobile,
    required String otp,
  }) async {
    /// Vérifie l’OTP et finalise l’authentification
    try {
      final result = await remoteDataSource.verifyOtpCode(
        mobile: mobile,
        otp: otp,
      );

      if (result.isError) {
        return Left(AuthFailure(result.comment));
      }

      // Vérification de la présence des données
      final data = result.data;
      if (data == null) {
        return const Left(ServerFailure('Données reçues vides ou corrompues'));
      }

      /// Sauvegarde de la session utilisateur après validation OTP
      await localDataSource.saveUser(data);
      await localDataSource.saveAuthToken(data.session!);

      return Right(data.toEntity());

    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Une erreur inattendue est survenue: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout({required LogoutReason reason}) async {
    /// Déconnecte l’utilisateur côté serveur et nettoie les données locales
    try {

      /// Gère la déconnexion de l’utilisateur.
      ///
      /// - Si la déconnexion est initiée par l’utilisateur, un appel au serveur est effectué.
      /// - Si elle est imposée par le serveur (session expirée, token invalide),
      ///   seul le nettoyage local est réalisé.
      /// - Les données locales sont toujours supprimées, quel que soit le résultat.

      final shouldCallServer = reason == LogoutReason.userInitiated;

      if(shouldCallServer) {
        final result = await remoteDataSource.logout();
        if (result.isError) {
          return Left(AuthFailure(result.comment));
        }
      }

      return const Right(unit);

    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Une erreur inattendue est survenue: $e'));
    } finally {
      /// Nettoyage systématique des données locales (token, utilisateur, cache)
      await localDataSource.clearUserData();
    }
  }

  @override
  Future<Either<Failure, String>> fetchUserGds({required String login}) async {
    // Récupère le GDS associé à un utilisateur
    try {
      final result = await remoteDataSource.fetchUserGds(login: login);

      if (result.isError) {
        return Left(AuthFailure(result.comment));
      }

      // Vérification de la présence des données
      final data = result.data;
      if (data == null) {
        return const Left(ServerFailure('Données reçues vides ou corrompues'));
      }

      return Right(data);

    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Une erreur inattendue est survenue: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    // Retourne l’utilisateur actuellement stocké en local
    try {
      final userJson = await localDataSource.getCurrentUser();

      if (userJson == null) {
        return Left(AuthFailure("Utilisateur introuvable"));
      }

      return Right(userJson.toEntity());

    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure('Une erreur inattendue est survenue: $e'));
    }
  }


  @override
  Future<Either<Failure, Unit>> resetPassword({required String userKey, required String password, required String gds}) async {
    // Réinitialisation de mot de passe
    try {

      final result = await remoteDataSource.resetPassword(
        userKey: userKey,
        password: password,
        gds: gds,
      );

      if (result.isError) {
        return Left(AuthFailure(result.comment));
      }

      return const Right(unit);

    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Une erreur inattendue est survenue: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveUser({required User user}) async {

    try {

      final userModel = UserModel.fromEntity(user);

      // Persistance
      await localDataSource.saveUser(userModel);

      return const Right(unit);

    } catch (e) {
      return Left(UnknownFailure('Une erreur inattendue est survenue: $e'));
    }





  }

}


