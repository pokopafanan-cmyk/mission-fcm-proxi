import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../error/failure.dart';


/// **Classe Abstraite Générique (Interface de Cas d’Utilisation Métier)**
///
/// Cette classe définit le **contrat de base de tous les UseCases** de l’application.
/// Un UseCase représente **une action métier précise** que l’utilisateur peut effectuer
/// (ex: se connecter, demander un OTP, vérifier un code, créer un compte, etc.).
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Rôle dans l’architecture Clean
/// ─────────────────────────────────────────────────────────
///
/// Le UseCase se situe entre le **BLoC (ou Cubit)** et les **Repositories** :
///
/// UI → BLoC → UseCase → Repository → DataSource
///
/// - Le BLoC gère l’état de l’interface
/// - Le UseCase orchestre la **logique métier**
/// - Le Repository gère l’accès aux données
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Responsabilités d’un UseCase
/// ─────────────────────────────────────────────────────────
///
/// Un UseCase :
/// - Contient la **logique métier**
/// - Ordonne les appels aux repositories si nécessaire
/// - Applique les règles métier (validation, enchaînement, décisions)
/// - Retourne soit un succès, soit une erreur métier [Failure]
///
/// Un UseCase :
/// - ❌ ne dépend PAS de Flutter (Widget, BuildContext, etc.)
/// - ❌ ne gère PAS l’état de l’UI
/// - ❌ ne contient PAS de logique réseau ou de persistance
/// - ✅ est facilement testable (tests unitaires)
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Généricité
/// ─────────────────────────────────────────────────────────
///
/// * **SuccessType** : Type retourné en cas de succès (ex: User, Token, void)
/// * **Params** : Paramètres nécessaires à l’exécution de l’action
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Astuce Dart : méthode `call`
/// ─────────────────────────────────────────────────────────
///
/// La méthode `call` permet d’appeler une instance comme une fonction :
///
/// ```dart
/// signIn(params);
/// ```
///
/// au lieu de :
///
/// ```dart
/// signIn.execute(params);
/// ```
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Contrat fonctionnel
/// ─────────────────────────────────────────────────────────
///
/// Chaque UseCase :
/// 1. Prend des paramètres typés [Params]
/// 2. Retourne un [Either] :
///    - [Right] avec un [SuccessType] en cas de succès
///    - [Left] avec un [Failure] en cas d’échec
///
/// Le retour via [Either] force l’appelant à gérer explicitement
/// les cas de succès et d’erreur.
///
/// ─────────────────────────────────────────────────────────
/// 🔹 Exemple d’utilisation
/// ─────────────────────────────────────────────────────────
///
/// ```dart
/// final signInUseCase = SignIn(authRepository);
///
/// final result = await signInUseCase(
///   SignInParams(login: 'user', password: '1234'),
/// );
///
/// result.fold(
///   (failure) => print('Erreur: ${failure.message}'),
///   (success) => print('Connecté: ${success.user.name}'),
/// );
/// ```
abstract class UseCase<SuccessType, Params> {
  /// Exécute l’action métier.
  ///
  /// [params] : Paramètres requis pour l’exécution.
  /// Retourne :
  /// - [Right] avec le résultat en cas de succès
  /// - [Left] avec un [Failure] en cas d’échec
  Future<Either<Failure, SuccessType>> call(Params params);
}

/// Classe utilitaire pour les UseCases ne nécessitant aucun paramètre
/// (ex: Logout, CheckSession, GetCurrentUser).
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
