import 'package:go_router/go_router.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/route_path.dart';
import '../presentation/screens/account_screen.dart';
import '../presentation/screens/code_pin_screen.dart';
import '../presentation/screens/family_members_screen.dart';
import '../presentation/screens/request_password_reset_screen.dart';
import '../presentation/screens/reset_password_screen.dart';

import '../presentation/screens/signin_otp_screen.dart';
import '../presentation/screens/signin_screen.dart';
import '../presentation/screens/signup_otp_screen.dart';
import '../presentation/screens/signup_screen.dart';
import '../presentation/screens/verify_otp_screen.dart';

class AuthRoutes {

  static List<RouteBase> get routes => [

    // Page de connexion
    GoRoute(
      path: RoutePath.signIn.path,
      name: RoutePath.signIn.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const SignInScreen(),
          state: state,
        );
      },
    ),

    GoRoute(
      path: RoutePath.signInOtp.path,
      name: RoutePath.signInOtp.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const SignInOtpScreen(),
          state: state,
        );
      },
    ),


    // Page de connexion 2
    // GoRoute(
    //   path: RoutePath.signIn2.path,
    //   name: RoutePath.signIn2.name,
    //   pageBuilder: (context, state) {
    //     return AppPage.slide(
    //       child: const SignIn2Screen(),
    //       state: state,
    //     );
    //   },
    // ),

    // Page d'inscription
    GoRoute(
      path: RoutePath.signUp.path,
      name: RoutePath.signUp.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const SignUpScreen(),
          state: state,
        );
      },
    ),

    // Page de demande réinitialisation du mot de passe
    GoRoute(
      path: RoutePath.requestReset.path,
      name: RoutePath.requestReset.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const RequestPasswordResetScreen(),
          state: state,
        );
      },
    ),

    // Page de réinitialisation du mot de passe
    GoRoute(
      path: RoutePath.resetPassword.path,
      name: RoutePath.resetPassword.name,
      pageBuilder: (context, state) {
        final userKey = state.pathParameters['userKey']!;
        return AppPage.slide(
          child: ResetPasswordScreen(userKey: userKey),
          state: state,
        );
      },
    ),

    // Page OTP
    GoRoute(
      path: RoutePath.verifyOtp.path,
      name: RoutePath.verifyOtp.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const VerifyOtpScreen(),
          state: state,
        );
      },
    ),

    GoRoute(
      path: RoutePath.codePin.path,
      name: RoutePath.codePin.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const CodePinScreen(),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.signupOtp.path,
      name: RoutePath.signupOtp.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const SignupOtpScreen(),
          state: state,
        );
      },
    ),

    GoRoute(
      path: RoutePath.familyMember.path,
      name: RoutePath.familyMember.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const FamilyMemberScreen(),
          state: state,
        );
      },
    ),

    GoRoute(
      path: RoutePath.account.path,
      name: RoutePath.account.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const AccountScreen(),
          state: state,
        );
      },
    ),
  ];
}
