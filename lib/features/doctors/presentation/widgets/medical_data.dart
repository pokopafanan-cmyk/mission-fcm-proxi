// import '../../../../generated/assets.dart';
// import '../../data/model/medical_card.dart';
//
//
// class MedicalData {
//   static const List<MedicalCard> medicalCards = [
//
//     MedicalCard( name: "Trouver des soins",  imgPath: Assets.imagesFindCare,  routeName: 'find_care',),
//
//     MedicalCard( name: "Rendez-vous",  imgPath: Assets.imagesRdv,  routeName: 'appointments',),
//
//     MedicalCard( name: "Notes de visite",  imgPath: Assets.imagesNote,  routeName: 'patient_notes',),
//
//     MedicalCard( name: "Résultats de labo",  imgPath: Assets.imagesLabResult,  routeName: 'lab_results',),
//   ];
// }

import '../../../../generated/assets.dart';
import '../../data/model/medical_card.dart';

class MedicalData {
  // Changement de const à final ici aussi
  static final List<MedicalCard> medicalCards = [
    MedicalCard(
      name: "Trouver des soins",
      imgPath: Assets.images.findCare.path,
      routeName: 'find_care',
    ),
    MedicalCard(
      name: "Rendez-vous",
      imgPath: Assets.images.rdv.path,
      routeName: 'appointments',
    ),
    MedicalCard(
      name: "Notes de visite",
      imgPath: Assets.images.note.path,
      routeName: 'patient_notes',
    ),
    MedicalCard(
      name: "Résultats de labo",
      imgPath: Assets.images.labResult.path,
      routeName: 'lab_results',
    ),
  ];
}