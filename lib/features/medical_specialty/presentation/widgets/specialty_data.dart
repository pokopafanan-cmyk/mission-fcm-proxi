//
// import '../../../../generated/assets.dart';
// import '../../data/models/medecin_specialty.dart';
//
//
// class SpecialtyData {
//
//   static const List<MedicalSpecialty> specialties = [
//
//     MedicalSpecialty(name: "Consultation", iconPath: Assets.imagesConsulatation, color: 0xFFDEE9FF),
//
//     MedicalSpecialty(name: "Dental", iconPath: Assets.imagesDental, color: 0xFFFFF2DE),
//
//     MedicalSpecialty(name: "Heart", iconPath: Assets.imagesHeart, color: 0xFFFFDEE9),
//
//     MedicalSpecialty(name: "Hospitals", iconPath: Assets.imagesHospiatl, color: 0xFFFFEDEE),
//
//     MedicalSpecialty(name: "Medicines", iconPath: Assets.imagesMedicines, color: 0xFFE5FFDE),
//
//     MedicalSpecialty(name: "Physician", iconPath: Assets.imagesSurgeon, color: 0xFFDFF6FF),
//
//     MedicalSpecialty(name: "Skin", iconPath: Assets.imagesSkin, color: 0xFFFFDEE9),
//
//     MedicalSpecialty(name: "Surgeon", iconPath: Assets.imagesSurgeon, color: 0xFFFFEDEE),
//   ];
//
//
// }

import '../../../../generated/assets.dart';
import '../../data/models/medecin_specialty.dart';

class SpecialtyData {

  static final List<MedicalSpecialty> specialties = [
    MedicalSpecialty(name: "Consultation", iconPath: Assets.images.consulatation.path, color: 0xFFDEE9FF),
    MedicalSpecialty(name: "Dental", iconPath: Assets.images.dental.path, color: 0xFFFFF2DE),
    MedicalSpecialty(name: "Heart", iconPath: Assets.images.heart.path, color: 0xFFFFDEE9),
    MedicalSpecialty(name: "Hospitals", iconPath: Assets.images.hospiatl.path, color: 0xFFFFEDEE),
    MedicalSpecialty(name: "Medicines", iconPath: Assets.images.medicines.path, color: 0xFFE5FFDE),
    MedicalSpecialty(name: "Physician", iconPath: Assets.images.surgeon.path, color: 0xFFDFF6FF),
    MedicalSpecialty(name: "Skin", iconPath: Assets.images.skin.path, color: 0xFFFFDEE9),
    MedicalSpecialty(name: "Surgeon", iconPath: Assets.images.surgeon.path, color: 0xFFFFEDEE),
  ];
}