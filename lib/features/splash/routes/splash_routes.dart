import 'package:go_router/go_router.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/route_path.dart';
import '../presentation/screens/splash_screen.dart';


class SplashRoutes {

  static List<RouteBase> get routes => [
    GoRoute(
      path: RoutePath.splash.path,
      name: RoutePath.splash.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const SplashScreen(),
          state: state,
        );
      }
    ),
  ];
}
