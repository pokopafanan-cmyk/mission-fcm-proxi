import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {

  @EnviedField(varName: 'API_BASE_URL')
  static final String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'APP_TOKEN')
  static final String appToken = _Env.appToken;

  @EnviedField(varName: 'APP_KEY_SESSION')
  static final String appKeySession = _Env.appKeySession;

  @EnviedField(varName: 'GOOGLE_API_KEY')
  static final String googleApiKey = _Env.googleApiKey;
}