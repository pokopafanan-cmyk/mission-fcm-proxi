import 'package:equatable/equatable.dart';
import '../../../di/init_dependencies.dart';
import '../../../utils/app_utils.dart';

class User extends Equatable {

  final String nom;
  final String login;
  final String prenoms;
  final String email;
  final String mobile;
  final String active;
  final String dateCreation;

  const User({
    required this.login,
    required this.nom,
    required this.prenoms,
    required this.email,
    required this.mobile,
    required this.active,
    required this.dateCreation,
  });


  /// Formatage du numero de mobile
  String get displayMobile {
    if(mobile.length >= 13) {
      return "+${mobile.substring(0, 3)} ${sl<AppUtils>().formatNumberGroups(mobile.substring(3), 2)}";
    }
    return sl<AppUtils>().formatNumberGroups(mobile, 2);
  }

  /// Numero de mobile sans le code du pays
  String get localMobile => mobile.length >= 13 ? mobile.substring(3) : mobile;

  @override
  List<Object> get props => [nom, prenoms, login, email, mobile, active, dateCreation];

}




