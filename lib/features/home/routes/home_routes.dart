import 'package:go_router/go_router.dart';
import 'package:proxi/features/home/presentation/screens/notification_screen.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/route_path.dart';
import '../presentation/screens/home_screen.dart';


class HomeRoutes {

  static List<RouteBase> get routes => [

    GoRoute(
      path: RoutePath.home.path,
      name: RoutePath.home.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const HomeScreen(),
          state: state,
        );
      },
    ),

    GoRoute(
      path: RoutePath.notifier.path,
      name: RoutePath.notifier.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const NotificationScreen(),
          state: state,
        );
      },
    ),



  ];
}
