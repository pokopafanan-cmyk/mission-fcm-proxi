//
// import '../../../../generated/assets.dart';
// import '../../data/model/list_doctors.dart';
//
//
// class ListDoctorsData {
//
//   static const List<ListDoctors> doctors = [
//
//     ListDoctors(name: "Dr. Amina Diallo", specialty: "Pediatrician", hospital: "Siloam Hospitals", rating: 4.9, imageUrl: Assets.imagesDoctor4,),
//
//     ListDoctors(name: "Dr. Koffi Kouadio", specialty: "Cardiologist", hospital: "Heart Center", rating: 4.8, imageUrl: Assets.imagesDoctor1,),
//
//     ListDoctors(name: "Dr. Sarah Mansour", specialty: "Dermatologist", hospital: "Skin Clinic", rating: 4.7, imageUrl: Assets.imagesDoctor3,),
//
//     ListDoctors(name: "Dr. Amina Diallo", specialty: "Pediatrician", hospital: "Siloam Hospitals", rating: 8.9, imageUrl: Assets.imagesDoctor3),
//
//     ListDoctors(name: "Dr. Amina Diallo", specialty: "Pediatrician", hospital: "Siloam Hospitals", rating: 6.9, imageUrl: Assets.imagesDoctor4,),
//
//     ListDoctors(name: "Dr. Amina Diallo", specialty: "Pediatrician", hospital: "Siloam Hospitals", rating: 5.9, imageUrl: Assets.imagesDoctor1,),
//
//   ];
// }


import '../../../../generated/assets.dart';
import '../../data/model/list_doctors.dart';

class ListDoctorsData {
  // Changement de const à final pour accepter les .path dynamiques
  static final List<ListDoctors> doctors = [
    ListDoctors(
      name: "Dr. Amina Diallo",
      specialty: "Pediatrician",
      hospital: "Siloam Hospitals",
      rating: 4.9,
      imageUrl: Assets.images.doctor4.path,
    ),
    ListDoctors(
      name: "Dr. Koffi Kouadio",
      specialty: "Cardiologist",
      hospital: "Heart Center",
      rating: 4.8,
      imageUrl: Assets.images.doctor1.path,
    ),
    ListDoctors(
      name: "Dr. Sarah Mansour",
      specialty: "Dermatologist",
      hospital: "Skin Clinic",
      rating: 4.7,
      imageUrl: Assets.images.doctor3.path,
    ),
    ListDoctors(
      name: "Dr. Amina Diallo",
      specialty: "Pediatrician",
      hospital: "Siloam Hospitals",
      rating: 8.9, // (Note: un rating sur 5 ? À vérifier si c'est voulu :))
      imageUrl: Assets.images.doctor3.path,
    ),
    ListDoctors(
      name: "Dr. Amina Diallo",
      specialty: "Pediatrician",
      hospital: "Siloam Hospitals",
      rating: 6.9,
      imageUrl: Assets.images.doctor4.path,
    ),
    ListDoctors(
      name: "Dr. Amina Diallo",
      specialty: "Pediatrician",
      hospital: "Siloam Hospitals",
      rating: 5.9,
      imageUrl: Assets.images.doctor1.path,
    ),
  ];
}