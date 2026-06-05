
import 'package:fpdart/fpdart.dart';

import '../../../error/failure.dart';

/// Interface définissant les opérations liées au hachage et à la sécurisation des mots de passe.
///
/// Cette interface peut être implémentée par différentes stratégies de hachage
/// et sert également à générer des mots de passe/signatures pour les appels API.
abstract interface class PasswordHasher {

  /// Hash un mot de passe en clair.
  ///
  /// Retourne un tuple `(hashedPassword, gds)` où `gds` est le sel ou clé unique utilisée pour le hash.
  (String, String) hashPassword({required String rawPassword});

  /// Génère un token aléatoire de 32 caractères,
  /// souvent utilisé pour le GDS ou la session.
  String generateToken32Chars();

  /// Hash un mot de passe en utilisant le GDS fourni.
  /// Utile pour la validation côté serveur ou les mises à jour de mot de passe.
  String hashPasswordWithGds({required String rawPassword, required String gds});


  /// Prépare un mot de passe à partir du login et du mot de passe en clair
  /// (récupération du GDS + hash du mot de passe)
  Future<Either<Failure, String>> preparePassword({
    required String login,
    required String rawPassword,
  });

}

