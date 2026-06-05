import 'dart:convert';
import 'package:http/http.dart' as http;
import '../events/auth_bus_event.dart';
import '../utils/app_logger.dart';
import '../events/auth_events.dart';
import 'prepared_request.dart';

/// Intercepteur HTTP global
/// - Ajoute les headers de sécurité
/// - Injecte le token de session si présent
/// - Analyse les réponses pour gérer les cas globaux (ex: logout)
class Interceptor extends http.BaseClient {

  /// Client HTTP réel (wrapper pour http)
  final http.Client inner;

  /// Fournisseur du token de session (clé utilisateur)
  final PreparedRequest preparedRequest;

  Interceptor({
    required this.inner,
    required this.preparedRequest,
  });

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {


    final headers = await preparedRequest.prepare();

    request.headers.addAll(headers);

    // Logger la requête (uniquement en debug)
    _logRequest(request);

    // Envoi réel de la requête HTTP
    final response = await inner.send(request).timeout(const Duration(seconds: 30));

    // Lecture complète du body de la réponse
    final bytes = await response.stream.toBytes();

    // Conversion en String (UTF-8)
    final body = utf8.decode(bytes);

    // Tentative de décodage JSON
    final decoded = _decodeBody(body);

    // Analyse globale de la réponse (logout forcé, session expirée, etc.)
    _handleResponse(response.statusCode, decoded);

    // Recréation de la réponse HTTP, Obligatoire vehicle le stream a été consommé;
    // Permet au reste de l’app (ApiClient / Repository) de lire la réponse normalement
    return http.StreamedResponse(
      Stream.value(bytes),
      response.statusCode,
      headers: response.headers,
      request: response.request,
      reasonPhrase: response.reasonPhrase,
    );
  }

  /// Décode le body JSON si possible
  dynamic _decodeBody(String body) {
    try {
      AppLogger.info('RESPONSE BODY: $body');
      return json.decode(body);
    } catch (_) {
      return null;
    }
  }

  /// Analyse globale de la réponse HTTP
  /// Permet de déclencher des actions transverses (logout, session expirée)
  void _handleResponse(int statusCode, dynamic decoded) {
    // 401 ou règle métier spécifique → logout forcé
    if (statusCode == 401 || _shouldForceLogout(decoded)) {
      GlobalAuthEventBus.emit(
        ForceLogoutEvent(reason: 'Session expirée'),
      );
    }
  }

  /// Règle métier spécifique au backend, Ici : answer == '-1' signifie session invalide
  bool _shouldForceLogout(dynamic data) {
    return data is Map && data['answer'] != null && data['answer'] == '-1';
  }

  /// Logger réseau (requêtes + headers + body)
  void _logRequest(http.BaseRequest request) {

    if (request is http.Request) {
      AppLogger.info('BODY SEND SERVER: ${request.body}');
    }

    AppLogger.info('REQUEST[${request.method}] => URL: ${request.url}');
    AppLogger.info('Headers: ${request.headers}');
  }
}
