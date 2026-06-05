// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'app/authentication/bloc/auth_bloc.dart';
// import 'app/loader/presentation/bloc/loader_bloc.dart';
// import 'app/loader/presentation/bloc/loader_observer.dart';
// import 'app/loader/presentation/widgets/loader_listener.dart';
// import 'app/router/app_router.dart';
// import 'core/common/domain/services/time_sync_service.dart';
// import 'core/di/init_dependencies.dart';
// import 'core/theme/app_color.dart';
// import 'core/theme/app_theme.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';
// import 'features/Profile/presentation/bloc/change_password/change_password_bloc.dart';
// import 'features/Profile/presentation/bloc/update_user/update_user_bloc.dart';
// import 'features/Profile/presentation/bloc/users/users_bloc.dart';
// import 'features/auth/presentation/bloc/request_password_reset/request_password_reset_bloc.dart';
// import 'features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
// import 'features/auth/presentation/bloc/signin/signin_bloc.dart';
// import 'features/auth/presentation/bloc/signin2/signin2_bloc.dart';
// import 'features/auth/presentation/bloc/signup/signup_bloc.dart';
// import 'features/auth/presentation/bloc/timer/timer_bloc.dart';
//
// late List<CameraDescription> cameras;
// final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> shellAuthNavigatorKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();
//
//
// Future<void> main() async {
//   // enableFlutterDriverExtension();
//   WidgetsFlutterBinding.ensureInitialized();
//
//
//   // Initialize dependencies
//   await initDependencies();
//   // Initialize Time Sync Service
//   await sl<TimeSyncService>().synchronize();
//   // get device camera available
//   cameras = await availableCameras();
//
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: AppColor.primaryColor,
//       statusBarBrightness: Brightness.light,
//       statusBarIconBrightness: Brightness.light,
//     ),
//   );
//
//
//   if (kDebugMode) await WakelockPlus.enable();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//
//   late final AppRouter _appRouter;
//   late final AuthBloc _authBloc;
//   late final LoaderBloc _loaderBloc;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _authBloc = sl<AuthBloc>();
//     _loaderBloc = sl<LoaderBloc>();
//     _appRouter = AppRouter(authBloc: _authBloc);
//     Bloc.observer = LoaderObserver(_loaderBloc);
//
//   }
//
//
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//
//     return MultiBlocProvider(
//       providers: [
//
//         // BlocProvider<PinBloc>(create: (_) => sl<PinBloc>()),
//         //   BlocProvider<AppLockBloc>(create: (_) => sl<AppLockBloc>()),
//
//         BlocProvider<AuthBloc>.value(value: _authBloc),
//         BlocProvider<LoaderBloc>.value(value: _loaderBloc),
//
//         BlocProvider<TimerBloc>(create: (_) => sl<TimerBloc>()),
//         BlocProvider<SignUpBloc>(create: (_) => sl<SignUpBloc>()),
//         BlocProvider<SignInBloc>(create: (_) => sl<SignInBloc>()),
//         BlocProvider<SignIn2Bloc>(create: (_) => sl<SignIn2Bloc>()),
//         BlocProvider<RequestPasswordResetBloc>(create: (_) => sl<RequestPasswordResetBloc>()),
//         BlocProvider<ResetPasswordBloc>(create: (_) => sl<ResetPasswordBloc>()),
//         BlocProvider<UpdateUserBloc>(create: (_) => sl<UpdateUserBloc>()),
//         BlocProvider<ChangePasswordBloc>(create: (_) => sl<ChangePasswordBloc>()),
//         BlocProvider<UsersBloc>(create: (_) => sl<UsersBloc>()),
//
//
//
//       ],
//       child: MaterialApp.router(
//         builder: (context, child) {
//           return LoaderListener(
//             child: StyledToast(
//               fullWidth: true,
//               isIgnoring: true,
//               axis: Axis.horizontal,
//               isHideKeyboard: false,
//               alignment: Alignment.center,
//               textAlign: TextAlign.center,
//               curve: Curves.linearToEaseOut,
//               reverseCurve: Curves.fastOutSlowIn,
//               startOffset: const Offset(1.0, 0.0),
//               duration: const Duration(seconds: 6),
//               reverseEndOffset: const Offset(1.0, 0.0),
//               animDuration: const Duration(seconds: 1),
//               borderRadius: BorderRadius.circular(5.0),
//               toastAnimation: StyledToastAnimation.slideFromRight,
//               reverseAnimation: StyledToastAnimation.slideToRight,
//               textStyle: const TextStyle(color: Colors.white, fontSize: 14.0),
//               backgroundColor: Colors.green,
//               textPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//               toastPositions: StyledToastPosition.top,
//               child: child ?? const SizedBox.shrink(),
//             ),
//           );
//         },
//         debugShowCheckedModeBanner: false,
//         title: 'S.T Standardization',
//         theme: AppTheme.themeData,
//         routerConfig: _appRouter.router,
//
//
//         localizationsDelegates: const [
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ],
//         supportedLocales: const [Locale('fr', 'FR')],
//         locale: const Locale('fr'),
//       ),
//     );
//   }
// }
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'app/authentication/bloc/auth_bloc.dart';
import 'app/loader/presentation/bloc/loader_bloc.dart';
import 'app/loader/presentation/bloc/loader_observer.dart';
import 'app/loader/presentation/widgets/loader_listener.dart';
import 'app/router/app_router.dart';
import 'core/common/domain/services/time_sync_service.dart';
import 'core/di/init_dependencies.dart';
import 'core/theme/app_color.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'features/Profile/presentation/bloc/change_password/change_password_bloc.dart';
import 'features/Profile/presentation/bloc/update_user/update_user_bloc.dart';
import 'features/Profile/presentation/bloc/users/users_bloc.dart';
import 'features/auth/presentation/bloc/request_password_reset/request_password_reset_bloc.dart';
import 'features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'features/auth/presentation/bloc/signin/signin_bloc.dart';
import 'features/auth/presentation/bloc/signin2/signin2_bloc.dart';
import 'features/auth/presentation/bloc/signup/signup_bloc.dart';
import 'features/auth/presentation/bloc/timer/timer_bloc.dart';

// ── APPORTS POUR LES NOTIFICATIONS ──
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

late List<CameraDescription> cameras;
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellAuthNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

// Rendre le rootNavigatorKey accessible pour ton NotificationService
final GlobalKey<NavigatorState> notificationNavigatorKey = rootNavigatorKey;

// Handler requis pour les notifications quand l'application est fermée ou en arrière-plan
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async {
  // enableFlutterDriverExtension();
  WidgetsFlutterBinding.ensureInitialized();

  // ── INITIALISATION FIREBASE APPORTÉE ──
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize dependencies
  await initDependencies();
  // Initialize Time Sync Service
  await sl<TimeSyncService>().synchronize();
  // get device camera available
  cameras = await availableCameras();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  if (kDebugMode) await WakelockPlus.enable();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final AppRouter _appRouter;
  late final AuthBloc _authBloc;
  late final LoaderBloc _loaderBloc;

  @override
  void initState() {
    super.initState();

    _authBloc = sl<AuthBloc>();
    _loaderBloc = sl<LoaderBloc>();
    _appRouter = AppRouter(authBloc: _authBloc);
    Bloc.observer = LoaderObserver(_loaderBloc);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        // BlocProvider<PinBloc>(create: (_) => sl<PinBloc>()),
        //   BlocProvider<AppLockBloc>(create: (_) => sl<AppLockBloc>()),

        BlocProvider<AuthBloc>.value(value: _authBloc),
        BlocProvider<LoaderBloc>.value(value: _loaderBloc),

        BlocProvider<TimerBloc>(create: (_) => sl<TimerBloc>()),
        BlocProvider<SignUpBloc>(create: (_) => sl<SignUpBloc>()),
        BlocProvider<SignInBloc>(create: (_) => sl<SignInBloc>()),
        BlocProvider<SignIn2Bloc>(create: (_) => sl<SignIn2Bloc>()),
        BlocProvider<RequestPasswordResetBloc>(create: (_) => sl<RequestPasswordResetBloc>()),
        BlocProvider<ResetPasswordBloc>(create: (_) => sl<ResetPasswordBloc>()),
        BlocProvider<UpdateUserBloc>(create: (_) => sl<UpdateUserBloc>()),
        BlocProvider<ChangePasswordBloc>(create: (_) => sl<ChangePasswordBloc>()),
        BlocProvider<UsersBloc>(create: (_) => sl<UsersBloc>()),
      ],
      child: MaterialApp.router(
        builder: (context, child) {
          return LoaderListener(
            child: StyledToast(
              fullWidth: true,
              isIgnoring: true,
              axis: Axis.horizontal,
              isHideKeyboard: false,
              alignment: Alignment.center,
              textAlign: TextAlign.center,
              curve: Curves.linearToEaseOut,
              reverseCurve: Curves.fastOutSlowIn,
              startOffset: const Offset(1.0, 0.0),
              duration: const Duration(seconds: 6),
              reverseEndOffset: const Offset(1.0, 0.0),
              animDuration: const Duration(seconds: 1),
              borderRadius: BorderRadius.circular(5.0),
              toastAnimation: StyledToastAnimation.slideFromRight,
              reverseAnimation: StyledToastAnimation.slideToRight,
              textStyle: const TextStyle(color: Colors.white, fontSize: 14.0),
              backgroundColor: Colors.green,
              textPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              toastPositions: StyledToastPosition.top,
              child: child ?? const SizedBox.shrink(),
            ),
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'S.T Standardization',
        theme: AppTheme.themeData,
        routerConfig: _appRouter.router,

        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('fr', 'FR')],
        locale: const Locale('fr'),
      ),
    );
  }
}