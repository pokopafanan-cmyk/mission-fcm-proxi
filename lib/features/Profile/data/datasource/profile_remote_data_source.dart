import "../../../../core/common/data/models/api_result.dart";
import "../../../../core/common/data/models/user_model.dart";
import "../../../../core/error/exceptions.dart";
import "../../../../core/http/api_client.dart";
import "../../../../core/http/api_endpoints.dart";
import "../../../../core/utils/app_logger.dart";

abstract interface class ProfileRemoteDataSource {

  /// Modifier les infos de l’utilisateur
  Future<ApiResult<UserModel>> updateUser({
    required String login,
    required String nom,
    required String prenoms,
    required String email,
    required String mobile,
  });
  
  /// Modifier le Mot de passe de l’utilisateur
  Future<ApiResult<void>> changePassword({
    required String login,
    required String oldPassword,
    required String newPassword,
    required String gds,
  });

  /// Récupérer les utilisateurs
  Future<ApiResult<List<UserModel>>> getUsers({
    required int page, 
    required int limit,
  });
}


class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {

  /// Client API pour communiquer avec le serveur
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ApiResult<UserModel>> updateUser({
    required String login,
    required String nom,
    required String prenoms,
    required String email,
    required String mobile,
  }) async {
    /// Modifier les infos de l’utilisateur
    try {

      // Requête réelle vers l’API
      final res = await apiClient.postData(
        uri: ApiEndpoints.updateUserUri,
        body: {
          "user_login": login,
          "user_nom": nom,
          "user_prenoms": prenoms,
          "user_email": email,
          "user_mobile": mobile,
        },
      );

      // Décodage de la réponse JSON
      final result = apiClient.decode(res);

      // Conversion de la réponse
      return ApiResult<UserModel>.fromMap(
        result,
        mapMapper: (data) => UserModel.fromMap(data),
      );

    } on AppException {
      rethrow;
    } catch (e, stack) {
      AppLogger.error(
        "[ProfileRemoteDataSource][updateUserInfos] Unknown error: $e",
        stackTrace: stack,
      );
      throw ServerException("Une erreur inattendue est survenue lors de la modification du compte $e");
    }
  }


  @override
  Future<ApiResult<void>> changePassword({
    required String login,
    required String oldPassword,
    required String newPassword,
    required String gds,
  }) async {
    /// Modifier le Mot de passe de l’utilisateur
    try {

      // Requête réelle vers l’API
      final res = await apiClient.postData(
        uri: ApiEndpoints.changePwdUri,
        body: {
          "user_login": login,
          "user_gds": gds,
          "user_oldpsw": oldPassword,
          "user_password": newPassword,
        },
      );
      final result = apiClient.decode(res);

      return ApiResult<void>.fromMap(result);

    } on AppException {
      rethrow;
    } catch (e, stack) {
      AppLogger.error(
        "[ProfileRemoteDataSource][updatePassword] Unknown error: $e",
        stackTrace: stack,
      );
      throw ServerException("Une erreur inattendue est survenue lors de la modification du mot de passe $e");
    }
  }

  @override
  Future<ApiResult<List<UserModel>>> getUsers({required int page, required int limit}) async {
    /// Récupérer les utilisateurs
    try {

      // Requête réelle vers l’API
      final res = await apiClient.getData(uri: ApiEndpoints.listUserUri);
      final result = apiClient.decode(res);

      return ApiResult<List<UserModel>>.fromMap(
        result,
        listMapper: (list) => list.map((e) => UserModel.fromMap(e)).toList(),
      );

    } on AppException {
      rethrow;
    } catch (e, stack) {
      AppLogger.error(
        "[ProfileRemoteDataSource][getUsers] Unknown error: $e",
        stackTrace: stack,
      );
      throw ServerException("Une erreur inattendue est survenue récupération des utilisateurs $e");
    }
  }
}

