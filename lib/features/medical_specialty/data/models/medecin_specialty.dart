import 'package:equatable/equatable.dart';

class MedicalSpecialty extends Equatable {
  final String name;
  final String iconPath;
  final int color;

  const MedicalSpecialty({
    required this.name,
    required this.iconPath,
    required this.color,
  });

  MedicalSpecialty copyWith({
    String? name,
    String? iconPath,
    int? color,
  }) {
    return MedicalSpecialty(
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
      color: color ?? this.color,
    );
  }

  factory MedicalSpecialty.fromMap(Map<String, dynamic> map) {
    return MedicalSpecialty(
      name: map['name'] as String? ?? '',
      iconPath: map['iconPath'] as String? ?? '',
      color: map['color'] as int? ?? 0xFFFFFFFF,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconPath': iconPath,
      'color': color,
    };
  }

  @override
  List<Object?> get props => [name, iconPath, color];
}