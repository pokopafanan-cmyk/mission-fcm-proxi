import '../../../../core/common/domain/services/password_hasher.dart';
import 'package:fpdart/fpdart.dart';
import 'package:crypto/crypto.dart';
import '../../../../core/error/failure.dart';
import '../../../../env/env.dart';
import 'dart:convert';
import 'dart:math';
import '../../domain/repositories/auth_repository.dart';

/// Implémentation concrète de l'interface [PasswordHasher].
///
/// Fournit des méthodes pour hasher des mots de passe,
/// générer des tokens de sécurité et produire des mots de passe
/// spécifiques pour les appels API.
class PasswordHasherImpl implements PasswordHasher {

  /// Repository d'authentification (récupération du GDS)
  final AuthRepository authRepository;

  PasswordHasherImpl({
    required this.authRepository,
  });

  /// Génère un token aléatoire de 32 caractères,
  /// utilisé comme GDS ou sel pour le hachage des mots de passe.
  @override
  String generateToken32Chars() {
    final random = Random.secure();
    final bytes = List<int>.generate(24, (i) => random.nextInt(256));
    return base64Url.encode(bytes).replaceAll('=', '');
  }

  /// Hash un mot de passe en générant un GDS aléatoire.
  ///
  /// Retourne un tuple `(gds, hashedPassword)` :
  /// - `gds` : le sel généré aléatoirement,
  /// - `hashedPassword` : le mot de passe hashé avec le sel.
  @override
  (String, String) hashPassword({required String rawPassword}) {
    final token = generateToken32Chars();
    final salted = '$token$rawPassword$token';
    final hash = sha256.convert(utf8.encode(salted)).toString();
    return (token, hash);
  }

  /// Hash un mot de passe en utilisant un GDS existant.
  ///
  /// Utilisé pour valider ou mettre à jour un mot de passe côté serveur.
  @override
  String hashPasswordWithGds({required String rawPassword, required String gds}) {
    final salted = '$gds$rawPassword$gds';
    final hashedPassword = sha256.convert(utf8.encode(salted)).toString();
    return hashedPassword;
  }


  @override
  Future<Either<Failure, String>> preparePassword({
    required String login,
    required String rawPassword,
  }) async {
    // Récupération du GDS associé à l'utilisateur
    final gdsResult = await authRepository.fetchUserGds(login: login);

    // Hash du mot de passe avec le GDS récupéré
    return gdsResult.map((gds) {
      final hashedPassword = hashPasswordWithGds(
        rawPassword: rawPassword,
        gds: gds,
      );

      return hashedPassword;
    });
  }
}