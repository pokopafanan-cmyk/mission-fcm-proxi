import 'dart:async';
import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// GoRouterRefreshStream
/// ---------------------------------------------------------------------------
/// Cette classe permet de transformer un ou plusieurs Streams en un
/// ChangeNotifier utilisable par GoRouter (ou tout autre widget Flutter).
///
/// RÔLE PRINCIPAL :
/// ----------------
/// Écouter une liste de Streams (ex : un SessionBloc, un userBloc, etc.)
/// et appeler `notifyListeners()` à chaque nouvel événement.
///
/// Cela permet, par exemple :
///   - De rafraîchir automatiquement GoRouter quand l'état du SessionBloc change.
///   - De redessiner un widget quand plusieurs Streams émettent.
///
/// En résumé : c’est **un pont entre des Streams et un ChangeNotifier**.
/// ---------------------------------------------------------------------------

class GoRouterRefreshStream extends ChangeNotifier {

  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((dynamic state) => notifyListeners(),);
  }


  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
