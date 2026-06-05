import '../../../../core/common/domain/entities/user.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_local_data_source.dart';
import '../datasource/profile_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';

class ProfileRepositoryImpl implements ProfileRepository {

  /// Source de données locale (cache, storage sécurisé, session)
  final ProfileLocalDataSource localDataSource;

  /// Source de données distante (API, backend)
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> updateUser({
    required String login,
    required String nom,
    required String prenoms,
    required String email,
    required String mobile,
  }) async {
    /// Modifications des infos d’un utilisateur via l’API
    try {
      final result = await remoteDataSource.updateUser(
        login: login,
        nom: nom,
        prenoms: prenoms,
        email: email,
        mobile: mobile,
      );

      if (result.isError) {
        return Left(AppFailure(result.comment));
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
  Future<Either<Failure, Unit>> changePassword({
    required String login,
    required String newPassword,
    required String oldPassword,
    required String gds,
  }) async {
    /// Modifications du Mot de passe d’un utilisateur via l’API
    try {
      final result = await remoteDataSource.changePassword(
        login: login,
        oldPassword: oldPassword,
        newPassword: newPassword,
        gds: gds,
      );

      if (result.isError) {
        return Left(AppFailure(result.comment));
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
  Future<Either<Failure, List<User>>> getUsers({required int page, required int limit}) async {
    try {
      final result = await remoteDataSource.getUsers(page: page, limit: limit);

      if (result.isError) {
        return Left(AppFailure(result.comment));
      }

      // Vérification de la présence des données
      final data = result.data;
      if (data == null) {
        return const Left(ServerFailure('Données reçues vides ou corrompues'));
      }

      // Conversion
      return Right(data.map((m) => m.toEntity()).toList());

    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Une erreur inattendue est survenue: $e'));
    }
  }

}


