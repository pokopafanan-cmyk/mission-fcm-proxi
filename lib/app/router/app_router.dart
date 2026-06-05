import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/app_logger.dart';
import '../../features/auth/routes/auth_routes.dart';
import '../../features/doctors/routes/doctors_route.dart';
import '../../features/find_care/route/fine_care_route.dart';
import '../../features/home/presentation/screens/main_app.dart';
import '../../features/home/routes/home_routes.dart';
import '../../features/splash/routes/splash_routes.dart';
import '../../main.dart';
import '../authentication/bloc/auth_bloc.dart';
import 'route_path.dart';
import 'refresh_stream.dart';

class AppRouter {

  /// Le bloc qui gère l'état de l'authentication (authentifié / non authentifié)
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  /// Expose l'instance de GoRouter à l'extérieur
  GoRouter get router => _router;

  /// Liste des routes accessibles sans être connecté (authentication screens)
  Set<String> get _authRoutes => {
    RoutePath.signIn.path,
    RoutePath.signIn2.path,
    RoutePath.signUp.path,
    RoutePath.requestReset.path,
    // RoutePath.resetPassword.path,
    RoutePath.verifyOtp.path,
  };

  /// L’instance principale du routeur GoRouter
  late final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,

    /// Permet au router de se rafraîchir automatiquement quand le AuthBloc change d’état
    refreshListenable: GoRouterRefreshStream(authBloc.stream),

    /// Première page affichée
    // initialLocation: RoutePath.splash.path,
    //initialLocation: RoutePath.signupOtp.path,
    initialLocation: RoutePath.notifier.path,
    //initialLocation: RoutePath.doctorsDetails.path,
    // initialLocation: RoutePath.listCacao.path,
    // initialLocation: RoutePath.listContainer.path,

    /// Définition des routes de l'application
    routes: <RouteBase>[
      ...SplashRoutes.routes,
      ...AuthRoutes.routes,

      ShellRoute(
        // navigatorKey: shellNavigatorKey,
        // parentNavigatorKey: rootNavigatorKey,
        builder: (context, state, child) {
          return MainApp(child: child);
        },
        routes: [
          ...HomeRoutes.routes,
          ... DoctorsRoutes.routes,
          ... FineCareRoute.routes,
         // ...RiceRoutes.routes,
         // ...VehicleRoutes.routes
        ],
      ),
    ],

    /// Logique de redirection automatique selon l'état de authentication
    // redirect: _handleRedirect,

    /// Page affichée si aucune route ne correspond
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text("No route defined for ${state.matchedLocation}"),
        ),
      );
    },
  );

  /// Détermine si une route appartient à la section authentication
  bool _isAuthPath(String matchedLocation) => matchedLocation.startsWith('/auth');

  /// Détermine si une route appartient à la section protégée (après login)
  bool _isProtectedPath(String matchedLocation) => matchedLocation.startsWith('/app');

  String? _handleRedirect(BuildContext context, GoRouterState state) {

    final auth = authBloc.state;
    final path = state.uri.path;
    final matched = state.matchedLocation;
    // final pinBloc = context.read<PinBloc>();

    AppLogger.info("Redirect check: path=$path | matched=$matched | state=$auth");

    // Traitement pour la splash screen
    final isSplashScreen = matched == RoutePath.splash.path;

    // Si déconnexion en cours → NE PAS REDIRIGER, laisser le loader
    if (auth is AuthLoggingOut) {
      AppLogger.info("Déconnexion en cours, attendre sur place");
      return null;
    }

    // ÉTAT DE CHARGEMENT - Laisser sur la splash
    if (auth is AuthLoading || auth is AuthInitial) {
      AppLogger.info("Session loading/initial",);

      // Si on est déjà sur la splash, rester
      // if (isSplashScreen) {
      //   return null;
      // }

      if (_isAuthPath(path)) {
        return null;
      }

      // Sinon, rediriger vers la splash
      AppLogger.info("Redirect to splash while loading");
      return RoutePath.splash.path;
    }

    // UTILISATEUR NON AUTHENTIFIÉ
    if (auth is AuthUnauthenticated || auth is AuthFailure) {
      AppLogger.info("User NOT authenticated");

      if (_isAuthPath(path)) {
        return null;
      }

      // Si on est déjà sur une page d'authentication, rester
      // if (_authRoutes.contains(matched)) {
      //   AppLogger.info("Already on authentication page → OK");
      //   return null;
      // }

      // Si on est sur la splash, rediriger vers signIn
      // if (isSplashScreen) {
      //   AppLogger.info("Splash → SignIn (unauthenticated)");
      //   return RoutePath.signIn.path;
      // }

      // Pour toute autre page, rediriger vers signIn
      AppLogger.info("Protected page → SignIn");
      return RoutePath.signIn.path;
    }

    // UTILISATEUR AUTHENTIFIÉ
    if (auth is AuthAuthenticated) {
      AppLogger.info("User IS authenticated");

      // if (pinBloc.state.isSetup) {
      //   return RoutePath.savePin.path;
      // }

      // Si on est sur la splash, rediriger vers home
      if (isSplashScreen) {
        AppLogger.info("Splash → Home (authenticated)");
        return RoutePath.home.path;
      }

      // Si on tente d'accéder à une page d'authentication, rediriger vers home
      if (_authRoutes.contains(matched)) {
        AppLogger.info("Authenticated user on authentication page → Home");
        return RoutePath.home.path;
      }

      // Sinon, permettre l'accès
      AppLogger.info("Authenticated: allow navigation");
      return null;
    }

    // Par défaut (ne devrait jamais arriver)
    AppLogger.info("Default case → SignIn");
    return RoutePath.signIn.path;
  }


}


