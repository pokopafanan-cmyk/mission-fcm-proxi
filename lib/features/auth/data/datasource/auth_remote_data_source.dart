import "../../../../core/common/data/models/api_result.dart";
import "../../../../core/common/data/models/user_model.dart";
import "../../../../core/error/exceptions.dart";
import "../../../../core/http/api_client.dart";
import "../../../../core/http/api_endpoints.dart";
import "../../../../core/utils/app_logger.dart";
import "../models/otp_data_model.dart";

abstract interface class AuthRemoteDataSource {

  /// Inscription d’un utilisateur via l’API
  Future<ApiResult<void>> signUp({
    required String login,
    required String nom,
    required String prenoms,
    required String email,
    required String password,
    required String mobile,
    required String gds,
  });

  /// Authentification via login et mot de passe
  Future<ApiResult<UserModel>> signInWithLoginPassword({required String login, required String password});

  /// Demande l’envoi d’un OTP pour un numéro de téléphone
  Future<ApiResult<OtpDataModel>> requestOtpCode({required String mobile});

  /// Réinitialisation du mot de passe via l’API
  Future<ApiResult<void>> requestPasswordReset({required String email});

  /// Réinitialisation du mot de passe
  Future<ApiResult<void>> resetPassword({
    required String userKey,
    required String password,
    required String gds,
  });

  /// Vérifie le code OTP pour finaliser l’authentification
  Future<ApiResult<UserModel>> verifyOtpCode({required String mobile, required String otp});

  /// Récupère le GDS associé à un utilisateur
  Future<ApiResult<String>> fetchUserGds({required String login});

  /// Déconnecte l’utilisateur côté serveur
  Future<ApiResult<void>> logout();

}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  /// Client API pour communiquer avec le serveur
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ApiResult<void>> requestPasswordReset({required String email}) async {
    /// Lance la réinitialisation du mot de passe
    try {

      // Requête réelle vers l’API
      final res = await apiClient.postData(
        uri: ApiEndpoints.askRsetPwdUri,
        body: {"user_email": email},
      );

      // Décodage de la réponse JSON
      final result = apiClient.decode(res);

      // Conversion de la réponse
      return ApiResult<void>.fromMap(result);

    } on AppException {
      rethrow;
    } catch (e, stack) {
      AppLogger.error(
        "[AuthRemoteDataSource][forgotPassword] Unknown error: $e",
        stackTrace: stack,
      );
      throw ServerException("Une erreur inattendue est survenue lors de la demande de réinitialisation du mot de passe $e");
    }
  }

  @override
  Future<ApiResult<OtpDataModel>> requestOtpCode({required String mobile}) async {
    /// Envoie un OTP au numéro fourni
    try {

      // Requête réelle vers l’API
      final res = await apiClient.postData(
        uri: ApiEndpoints.askOtpUri,
        body: {"user_mobile": mobile},
      );

      // Décodage de la réponse JSON
      final result = apiClient.decode(res);

      // Conversion de la réponse
      return ApiResult<OtpDataModel>.fromMap(
        result,
        mapMapper: (data) => OtpDataModel.fromMap(data),
      );

    } on AppException {
      rethrow;
    } catch (e, stack) {
      AppLogger.error(
        "[AuthRemoteDataSource][requestOtpCode] Unknown error: $e",
        stackTrace: stack,
      );
      throw ServerException("Une erreur inattendue est survenue lors de la connexion $e");
    }
  }

  @override
  Future<ApiResult<UserModel>> signInWithLoginPassword({
    required String login,
    required String password,
  }) async {
    /// Authentifie l’utilisateur avec login et mot de passe
    try {

      // Requête réelle vers l’API
      final res = await apiClient.postData(
        uri: ApiEndpoints.signInUri,
        body: {
          "user_login": login,
          "user_password": password,
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
        "[AuthRemoteDataSource][signInWithLoginPassword] Unknown error: $e",
        stackTrace: stack,
      );
      throw ServerException("Une erreur inattendue est survenue lors de la connexion $e");
    }
  }

  @override
  Future<ApiResult<void>> signUp({
    required String login,
    required String nom,
    required String prenoms,
    required String email,
    required String password,
    required String mobile,
    required String gds,
  }) async {
    /// Création d’un nouvel utilisateur
    try {

      // Requête réelle vers l’API
      final res = await apiClient.postData(
        uri: ApiEndpoints.signUpUri,
        body: {
          "user_login": login,
          "user_nom": nom,
          "user_prenoms": prenoms,
          "user_email": email,
          "user_mobile": mobile,
          "user_gds": gds,
          "user_password": password,
        },
      );

      // Décodage de la réponse JSON
      final result = apiClient.decode(res);

      // Conversion de la réponse
      return ApiResult<void>.fromMap(result);

    } on AppException {
      rethrow;
    } catch (e, stack) {
      AppLogger.error(
        "[AuthRemoteDataSource][signUp] Unknown error: $e",
        stackTrace: stack,
      );
      throw ServerException("Une erreur inattendue est survenue lors de la création du compte $e");
    }
  }

  @override
  Future<ApiResult<String>> fetchUserGds({required String login}) async {
    /// Récupère le GDS de l’utilisateur
    try {

      // Requête réelle vers l’API
      final res = await apiClient.postData(
        uri: ApiEndpoints.gdsUri,
        body: {"user_login": login},
      );

      // Décodage de la réponse JSON
      final result = apiClient.decode(res);

      // Conversion de la réponse
      return ApiResult<String>.fromMap(
        result,
        mapMapper: (data) => data["user_gds"] as String,
      );

    } on AppException {
      rethrow;
    } catch (e, stack) {
      AppLogger.error(
        "[AuthRemoteDataSource][fetchUserGds] Unknown error: $e",
        stackTrace: stack,
      );
      throw ServerException("Une erreur inattendue est survenue lors de la récupération du GDS $e");
    }
  }

  @override
  Future<ApiResult<UserModel>> verifyOtpCode({required String mobile, required String otp}) async {
    /// Vérifie l’OTP et retourne l’utilisateur si valide
    try {

      // Requête réelle vers l’API
      final res = await apiClient.postData(
        uri: ApiEndpoints.checkOtpUri,
        body: {
          "user_code": otp,
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
        "[AuthRemoteDataSource][verifyOtpCode] Unknown error: $e",
        stackTrace: stack,
      );
      throw ServerException("Une erreur inattendue est survenue lors de la vérification du code OTP $e");
    }
  }

  @override
  Future<ApiResult<void>> logout() async {
    /// Déconnexion de l’utilisateur côté serveur
    try {

      // Requête réelle vers l’API
      final res = await apiClient.getData(uri: ApiEndpoints.logoutUri);

      // Décodage de la réponse JSON
      final result = apiClient.decode(res);

      // Conversion de la réponse
      return ApiResult<void>.fromMap(result);

    } on AppException {
      rethrow;
    } catch (e, stack) {
      AppLogger.error(
        "[AuthRemoteDataSource][logout] Unknown error: $e",
        stackTrace: stack,
      );
      throw ServerException("Une erreur inattendue est survenue lors de la déconnexion $e");
    }
  }

  @override
  Future<ApiResult<void>> resetPassword({
    required String userKey,
    required String password,
    required String gds,
  }) async {

    /// Réinitialisation du mot de passe
    try {

      // Requête réelle vers l’API
      final res = await apiClient.postData(
        uri: ApiEndpoints.resetPwdUri,
        body: {
          "user_key": userKey,
          "user_gds": gds,
          "user_password": password,
        },
      );

      // Décodage de la réponse JSON
      final result = apiClient.decode(res);

      // Conversion de la réponse
      return ApiResult<void>.fromMap(result);

    } on AppException {
      rethrow;
    } catch (e, stack) {
      AppLogger.error(
        "[AuthRemoteDataSource][resetPassword] Unknown error: $e",
        stackTrace: stack,
      );
      throw ServerException("Une erreur inattendue est survenue lors de la réinitialisation du mot de passe $e");
    }
  }
}
