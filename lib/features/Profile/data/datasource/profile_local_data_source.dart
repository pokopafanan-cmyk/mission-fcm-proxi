import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/common/data/models/user_model.dart';
import '../../../../core/config/app_constant.dart';
import '../../../../core/error/failure.dart';

abstract interface class ProfileLocalDataSource {}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {

  /// Stockage sécurisé pour les données sensibles
  final FlutterSecureStorage secureStorage;

  ProfileLocalDataSourceImpl({
    required this.secureStorage,
  });

}
