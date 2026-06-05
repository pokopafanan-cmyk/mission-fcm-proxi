import 'package:equatable/equatable.dart';

class FindCare extends Equatable {
  final String name;
  final String iconPath;
  final String specialty;

  const FindCare({
    required this.name,
    required this.iconPath,
    required this.specialty,
  });

  @override
  List<Object> get props => [name, iconPath, specialty];

  Map<String, dynamic> toMap() => {
    "name": name,
    "iconPath": iconPath,
    "specialty": specialty,
  };

  factory FindCare.fromMap(Map<String, dynamic> json) => FindCare(
    name: json["name"] as String,
    iconPath: json["iconPath"] as String,
    specialty: json["specialty"] as String,
  );
}