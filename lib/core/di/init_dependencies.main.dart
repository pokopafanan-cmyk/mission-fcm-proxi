part of 'init_dependencies.dart';

final sl = GetIt.instance;

Future <void> initDependencies() async {
  await _initCore();
  await _initAuth();
  await _initLocalAuth();
  await _initProfile();
}


Future <void> _initCore() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  // final database = await DatabaseHelper.instance.database;

  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_PKCS1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_CBC_PKCS7Padding,
    ),
    iOptions: IOSOptions(),
  );

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  // sl.registerLazySingleton<Database>(() => database);

  /// Services utils
  sl.registerLazySingleton<AppUtils>(() => AppUtils());
  sl.registerLazySingleton<TimeSyncService>(() => TimeSyncService());

  /// http client
  sl.registerLazySingleton<http.Client>(
    () => RetryClient(
      Interceptor(
        inner: http.Client(),
        preparedRequest: sl(),
      ),
    ),
  );

  /// Internet connexion
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      internetConnection: sl(),
    ),
  );

  /// API client
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      client: sl(),
      connectionChecker: sl()
    ),
  );

  /// Global auth BLOCS
  sl.registerLazySingleton<LoaderBloc>(() => LoaderBloc(),);
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(authService: sl()),);
}

Future <void> _initAuth() async {

  /// Auth data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(apiClient: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(secureStorage: sl(),));

  /// Auth repos
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));

  sl.registerLazySingleton<PasswordHasher>(() => PasswordHasherImpl(authRepository: sl()));

  sl.registerLazySingleton<PreparedRequest>(
        () => PreparedRequest(
      secureStorage: sl(),
      timeSyncService: sl(),
    ),
  );

  /// Auth Uses cases
  sl.registerLazySingleton<SignUp>(() => SignUp(authRepository: sl(), passwordHasher: sl()));
  sl.registerLazySingleton<SignIn>(() => SignIn(authRepository: sl(), passwordHasher: sl()));
  sl.registerLazySingleton<RequestOtpCode>(() => RequestOtpCode(authRepository: sl()));
  sl.registerLazySingleton<VerifyOtpCode>(() => VerifyOtpCode(authRepository: sl()));
  sl.registerLazySingleton<RequestPasswordReset>(() => RequestPasswordReset(authRepository: sl()));
  sl.registerLazySingleton<ResetPassword>(() => ResetPassword(authRepository: sl(), passwordHasher: sl(),));
  sl.registerLazySingleton<GetCurrentUser>(() => GetCurrentUser(authRepository: sl()));
  sl.registerLazySingleton<LogoutRequest>(() => LogoutRequest(authRepository: sl()));
  sl.registerLazySingleton<PersistUser>(() => PersistUser(authRepository: sl()));


  sl.registerLazySingleton<AuthService>(
        () => AuthServiceImpl(
      getCurrentUser: sl(),
      logoutRequest: sl(),
      persistUser: sl(),
    ),
  );

  /// Auth BLOCS
  sl.registerFactory<SignUpBloc>(() => SignUpBloc(signUp: sl(),),);
  sl.registerFactory<SignInBloc>(() => SignInBloc(signIn: sl(), authBloc: sl(),),);
  sl.registerFactory<SignIn2Bloc>(() => SignIn2Bloc(authBloc: sl(), verifyOtpCode: sl(), requestOtpCode: sl(),),);
  sl.registerFactory<RequestPasswordResetBloc>(() => RequestPasswordResetBloc(requestPasswordReset: sl()),);
  sl.registerFactory<ResetPasswordBloc>(() => ResetPasswordBloc(resetPassword: sl()),);

  /// Timer BLOCS
  sl.registerFactory<TimerBloc>(() => TimerBloc());
}

Future <void> _initLocalAuth() async {

  /// Local Auth data sources
  // sl.registerLazySingleton<LocalAuthentication>(() => LocalAuthentication());
  // sl.registerLazySingleton<BiometricDataSource>(() => BiometricDataSourceImpl(localAuthentication: sl()));
  // sl.registerLazySingleton<LocalAuthRemoteDataSource>(() => LocalAuthRemoteDataSourceImpl(apiClient: sl()));
  // sl.registerLazySingleton<LocalAuthLocalDataSource>(() => LocalAuthLocalDataSourceImpl(secureStorage: sl(),));

  /// Local Auth repos
  // sl.registerLazySingleton<LocalAuthRepository>(
  //   () => LocalAuthRepositoryImpl(
  //     remoteDataSource: sl(),
  //     localDataSource: sl(),
  //     biometricDataSource: sl(),
  //   ),
  // );

  /// Local Auth Uses cases
  // sl.registerLazySingleton<GetPinStatus>(() => GetPinStatus(localAuthRepository: sl()));
  // sl.registerLazySingleton<SavePin>(() => SavePin(localAuthRepository: sl()));
  // sl.registerLazySingleton<VerifyPin>(() => VerifyPin(localAuthRepository: sl()));
  // sl.registerLazySingleton<ChangePin>(() => ChangePin(localAuthRepository: sl()));
  // sl.registerLazySingleton<DeletePin>(() => DeletePin(localAuthRepository: sl()));
  // sl.registerLazySingleton<AuthenticateBiometric>(() => AuthenticateBiometric(localAuthRepository: sl()));
  // sl.registerLazySingleton<CheckBiometricAvailability>(() => CheckBiometricAvailability(localAuthRepository: sl()));

  /// Local Auth BLOCS
  // sl.registerLazySingleton<PinBloc>(
  //   () => PinBloc(
  //     getPinStatus: sl(),
  //     savePin: sl(),
  //     verifyPin: sl(),
  //     changePin: sl(),
  //     deletePin: sl(),
  //     authenticateBiometric: sl(),
  //     checkBiometricAvailability: sl(),
  //   ),
  // );

  // sl.registerLazySingleton<AppLockBloc>(() => AppLockBloc(timeSyncService: sl()));
}


Future <void> _initProfile() async {

  /// Profile data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(apiClient: sl()));
  sl.registerLazySingleton<ProfileLocalDataSource>(() => ProfileLocalDataSourceImpl(secureStorage: sl(),));

  /// Profile repos
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));

  /// Profile Uses cases
  sl.registerLazySingleton<UpdateUser>(() => UpdateUser(profileRepository: sl()));
  sl.registerLazySingleton<ChangePassword>(() => ChangePassword(profileRepository: sl(), passwordHasher: sl()));
  sl.registerLazySingleton<GetUsers>(() => GetUsers(profileRepository: sl()));

  /// Profile BLOCS
  sl.registerFactory<UpdateUserBloc>(() => UpdateUserBloc(updateUser: sl()),);
  sl.registerFactory<ChangePasswordBloc>(() => ChangePasswordBloc(changePassword: sl()),);
  sl.registerFactory<UsersBloc>(() => UsersBloc(getUsers: sl()),);
}