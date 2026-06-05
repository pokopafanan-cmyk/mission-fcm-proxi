//
// import '../../../../generated/assets.dart';
// import 'find_care_model.dart';
//
// class FindCareData {
//   static const List<FindCare> specialtie = [
//
//     FindCare(name: "Dr. Abraham Pigeon", iconPath: Assets.imagesDoctor1, specialty: "Physical Therapy",),
//
//     FindCare(name: "Dr. Pediatrician", iconPath: Assets.imagesDoctor2, specialty: "Cardiologist",),
//
//     FindCare(name: "Dr. Mistry Brick", iconPath: Assets.imagesDoctor3, specialty: "Dental Specialist",),
//
//     FindCare(name: "Dr. Johan Smith", iconPath: Assets.imagesDoctor4, specialty: "Dental Specialist",),
//
//     FindCare(name: "Dr. Linda Moore", iconPath: Assets.imagesDoctor1, specialty: "Neurologist",),
//
//     FindCare(name: "Dr. Kevin Lee", iconPath: Assets.imagesDoctor1, specialty: "Orthopedic",),
//   ];
// }

import '../../../../generated/assets.dart';
import 'find_care_model.dart';

class FindCareData {
  // Changement de const à final pour accepter les .path
  static final List<FindCare> specialtie = [
    FindCare(
      name: "Dr. Abraham Pigeon",
      iconPath: Assets.images.doctor1.path,
      specialty: "Physical Therapy",
    ),
    FindCare(
      name: "Dr. Pediatrician",
      iconPath: Assets.images.doctor2.path,
      specialty: "Cardiologist",
    ),
    FindCare(
      name: "Dr. Mistry Brick",
      iconPath: Assets.images.doctor3.path,
      specialty: "Dental Specialist",
    ),
    FindCare(
      name: "Dr. Johan Smith",
      iconPath: Assets.images.doctor4.path,
      specialty: "Dental Specialist",
    ),
    FindCare(
      name: "Dr. Linda Moore",
      iconPath: Assets.images.doctor1.path,
      specialty: "Neurologist",
    ),
    FindCare(
      name: "Dr. Kevin Lee",
      iconPath: Assets.images.doctor1.path,
      specialty: "Orthopedic",
    ),
  ];
}