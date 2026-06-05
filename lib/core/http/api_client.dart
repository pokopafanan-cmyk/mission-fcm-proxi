import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../env/env.dart';
import '../error/exceptions.dart';
import '../network/connection_checker.dart';
import '../utils/app_logger.dart';

class ApiClient {

  /// Client HTTP (peut être intercepté : headers, auth, logs, etc.)
  final http.Client client;

  /// Vérifie la disponibilité de la connexion réseau
  final ConnectionChecker connectionChecker;

  ApiClient({required this.client, required this.connectionChecker});

  /// static final _dateFormat = DateFormat('dd/MM/yyyy');

  /// Envoie une requête HTTP POST
  Future<http.Response> post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String> headers = const <String, String>{},
  }) async {
    return await _executeRequest(
      url: url,
      method: "POST",
      body: body,
      headers: headers,
    );
  }

  /// Envoie une requête HTTP GET
  Future<http.Response> get({
    required String url,
    Map<String, String> headers = const <String, String>{},
  }) async {
    return await _executeRequest(
      url: url,
      method: "GET",
      headers: headers,
    );
  }

  /// Envoie une requête POST vers l’API en utilisant l’URL de base
  Future<http.Response> postData({
    required String uri,
    required Map<String, dynamic> body,
    Map<String, String> headers = const <String, String>{},
  }) async {

    AppLogger.info('==== BODY SEND SERVER ${json.encode(body)} ====');

    final url = '${Env.baseUrl}$uri';
    return await post(url: url, body: body, headers: headers);
  }

  /// Envoie une requête GET vers l’API en utilisant l’URL de base
  Future<http.Response> getData({
    required String uri,
    Map<String, String> headers = const <String, String>{},
  }) async {
    final url = '${Env.baseUrl}$uri';
    return await get(url: url, headers: headers);
  }


  /// Méthode centrale d’exécution des requêtes HTTP
  ///
  /// - Vérifie la connexion réseau
  /// - Envoie la requête
  /// - Gère les erreurs techniques
  /// - Retourne une réponse valide ou lève une exception métier
  Future<http.Response> _executeRequest({
    required String url,
    required String method,
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {

    // Vérification de la connexion réseau
    final online = await connectionChecker.isConnected;
    if (!online) {
      throw NetworkException();
    }

    try {
      // Envoi réel de la requête HTTP
      final response = await _sendRequest(
        url: url,
        method: method,
        body: body,
        headers: headers,
      );

      // Analyse du code HTTP et mapping des erreurs
      return _handleResponse(response);

    } on TimeoutException {
      throw ServerException('Délai d\'attente dépassé. Veuillez réessayer.',);
    } on SocketException {
      throw ServerException('Problème de connexion réseau.',);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Une erreur inattendue est survenue.');
    } finally {
      client.close();
    }
  }


  /// Envoie la requête HTTP selon la méthode demandée
  Future<http.Response> _sendRequest({
    required String url,
    required String method,
    required Map<String, dynamic> body,
    required Map<String, String> headers,
  }) {
    final uri = Uri.parse(url);

    switch (method) {
      case 'POST':
        return client.post(uri, body: json.encode(body), headers: headers);
      case 'GET':
        return client.get(uri, headers: headers);
      default:
        throw ServerException('Méthode HTTP non supportée : $method');
    }
  }

  /// Vérifie le code HTTP et retourne la réponse ou une exception
  http.Response _handleResponse(http.Response res) {
    // AppLogger.info('HTTP ${res.statusCode} | ${res.body}');

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return res;
    }

    throw _mapHttpError(res);
  }

  /// Mappe les erreurs HTTP vers des exceptions métier
  AppException _mapHttpError(http.Response res) {

    String message = 'Erreur serveur, veuillez réessayer plus tard.';

    // Tentative de récupération du message backend
    try {
      final data = json.decode(res.body);
      if (data is Map && data['comment'] != null) {
        message = data['comment'];
      }
    } catch (_) {
      message = 'Données JSON mal formatées';
    }

    return ServerException(message, statusCode: res.statusCode);
  }


  /// Mappe les erreurs HTTP vers des exceptions métier
  AppException _mapHttpError2(http.Response res) {

    String message = 'Erreur serveur';

    // Tentative de récupération du message backend
    try {
      final data = json.decode(res.body);
      if (data is Map && data['comment'] != null) {
        message = data['comment'];
      }
    } catch (_) {
      message = 'Données JSON mal formatées';
    }

    switch (res.statusCode) {
      case 400:
        return ServerException(message, statusCode: 400);
      case 401:
      // return ServerException('Session expirée. Veuillez vous reconnecter.', statusCode: 401);
        return UnauthorizedException();
      case 403:
        return ServerException('Accès refusé.', statusCode: 403);
      case 404:
        return ServerException('Ressource introuvable.', statusCode: 404);
      case 500:
        return ServerException('Erreur serveur, veuillez réessayer plus tard.', statusCode: 500);
      default:
        return ServerException(message, statusCode: res.statusCode);
    }
  }



  /// Décode la réponse HTTP provenant de l’API Sycelim Technologies.
  /// Cette méthode doit être utilisée exclusivement pour les réponses retournées par les endpoints Sycelim Technologies.
  /// Lève une [ParsingException] si la réponse n’est pas un JSON valide.
  Map<String, dynamic> decode(http.Response response) {
    try {
      return json.decode(response.body) as Map<String, dynamic>;
    } on FormatException {
      throw ParsingException();
    }
  }


}
