import 'dart:async';
import 'auth_bus_event.dart';

/// Bus d'événements global dédié aux événements liés à l'authentification.
///
/// Cette classe permet aux couches basses (HTTP, interceptors, services)
/// de notifier le reste de l'application d'événements critiques
/// (ex: expiration de session, logout forcé)
/// sans dépendre de la couche UI ou des BLoC.
///
/// Elle implémente un mécanisme de publication / souscription (pub-sub)
/// simple basé sur des Streams Dart.
class GlobalAuthEventBus {

  /// Contrôleur de stream en mode broadcast.
  ///
  /// - `broadcast` permet à plusieurs listeners de s'abonner
  ///   simultanément (BLoC, services, observers…)
  /// - Le controller est statique afin d'être accessible
  ///   globalement dans l'application.
  static final StreamController<AuthBusEvent> _controller = StreamController<AuthBusEvent>.broadcast();

  /// Stream exposé permettant d'écouter les événements
  /// d'authentification.
  ///
  /// Exemple d'écoute :
  /// ```dart
  /// AuthEventBus.stream.listen((event) { ... });
  /// ```
  static Stream<AuthBusEvent> get stream => _controller.stream;

  /// Émet un événement d'authentification dans le bus.
  ///
  /// Cette méthode est typiquement appelée depuis :
  /// - un HttpInterceptor
  /// - un service réseau
  /// - un guard de sécurité
  ///
  /// Elle ne déclenche aucune action directe :
  /// elle se contente de notifier les listeners.
  static void emit(AuthBusEvent event) {
    _controller.add(event);
  }
}


