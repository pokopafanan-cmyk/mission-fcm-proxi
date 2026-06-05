import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../env/env.dart';
import '../common/domain/services/time_sync_service.dart';
import '../config/app_constant.dart';

/// Prépare les headers HTTP nécessaires avant l’envoi d’une requête vers l’API.
///
/// Cette classe centralise :
/// - l’ajout du token de session utilisateur (si disponible)
/// - la génération des headers de sécurité exigés par le backend
///
/// Elle permet de garantir que toutes les requêtes sortantes
/// respectent les règles d’authentification et de sécurité de l’API.
class PreparedRequest {

  /// Fournisseur du token de session (clé utilisateur)
  final FlutterSecureStorage secureStorage;

  /// Service de synchronisation de l’heure avec le backend
  final TimeSyncService timeSyncService;

  PreparedRequest({
    required this.secureStorage,
    required this.timeSyncService,
  });


  /// Construit et retourne l’ensemble des headers HTTP à envoyer.
  ///
  /// - Ajoute le token de session si l’utilisateur est connecté
  /// - Ajoute les headers de sécurité obligatoires (timestamp, signature, etc.)
  Future<Map<String, String>> prepare() async {

    final headers = <String, String>{};

    // Ajout du token de session si disponible
    await _addAuthToken(headers);

    // Ajouter les headers de sécurité requis par l’API
    _addSecurityHeaders(headers);

    return headers;
  }

  /// Récupère le token de session et l’ajoute aux headers si disponible
  Future<void> _addAuthToken(Map<String, String> headers) async {
    final sessionKey = await _getAuthToken();

    if (sessionKey?.isNotEmpty == true) {
      headers['Keys-Session'] = sessionKey!;
    }
  }

  /// Ajoute les headers de sécurité attendus par le backend
  void _addSecurityHeaders(Map<String, String> headers) {
    final timestamp = timeSyncService.timestamp();
    final password = _generateApiSignature(timestamp: timestamp);

    headers.addAll({
      // 'Content-Type': 'application/json',
      'Content-Type': 'application/json; charset=utf-8',
      'Token': 'Bearer ${Env.appToken}',
      'Password': password,
      'Timestamp': timestamp,
      // 'Content-Length': '$length',
      'Appname': 'mobapp',
    });
  }


  /// Génère un mot de passe d’API sécurisé à partir d’un timestamp
  /// La chaîne résultante est ensuite hashée avec l’algorithme SHA-256.
  String _generateApiSignature({required String timestamp}) {
    final input = "$timestamp${Env.appToken}$timestamp";
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Génère une signature d’API sécurisée via HMAC-SHA256
  ///
  /// - Le timestamp sert de message
  /// - Le token applicatif est utilisé comme clé secrète
  /// - La signature est vérifiable côté serveur
  String _generateApiSignature2({required String timestamp}) {
    final key = utf8.encode(Env.appToken);
    final message = utf8.encode(timestamp);

    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(message);

    return digest.toString();
  }

  /// Récupère le token d’authentification stocké de manière sécurisée
  /// Retourne `null` si aucun token n’est présent (utilisateur non connecté).
  Future<String?> _getAuthToken() async => await secureStorage.read(key: AppConstant.authTokenKey);


}