import 'package:go_router/go_router.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/route_path.dart';
import '../presentation/screens/change_password_screen.dart';
import '../presentation/screens/profil_screen.dart';
import '../presentation/screens/update_user_screen.dart';

class ProfileRoutes {

  static List<RouteBase> get routes => [

    // Page profil
    GoRoute(
      path: RoutePath.profile.path,
      name: RoutePath.profile.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const ProfilScreen(),
          state: state,
        );
      },
    ),

    // Page update user
    GoRoute(
      path: RoutePath.updateUser.path,
      name: RoutePath.updateUser.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const UpdateUserScreen(),
          state: state,
        );
      },
    ),

    // Page update password
    GoRoute(
      path: RoutePath.changePassword.path,
      name: RoutePath.changePassword.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const ChangePasswordScreen(),
          state: state,
        );
      },
    ),
  ];
}
