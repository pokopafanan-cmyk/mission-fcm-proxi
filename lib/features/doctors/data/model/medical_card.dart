import 'package:equatable/equatable.dart';

class MedicalCard extends Equatable {
  final String name;
  final String imgPath;
  final String routeName;

  const MedicalCard({
    required this.name,
    required this.imgPath,
    required this.routeName,
  });

  @override
  List<Object?> get props => [name, imgPath, routeName];
}