import 'package:go_router/go_router.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/route_path.dart';
import '../data/model/list_doctors.dart';
import '../presentation/screen/doctors_details_screen.dart';
import '../presentation/screen/medical_screen.dart';

class DoctorsRoutes {

  static List<RouteBase> get routes => [

    GoRoute(
      path: RoutePath.doctorsDetails.path,
      name: RoutePath.doctorsDetails.name,
      pageBuilder: (context, state) {
        // On cast l'objet passé en extra
        final doctor = state.extra as ListDoctors;

        return AppPage.slide(
          child: DoctorDetailsScreen(doctor: doctor),
          state: state,
        );
      },
    ),

    GoRoute(
      path: RoutePath.medicalCard.path,
      name: RoutePath.medicalCard.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const MedicalScreen(),
          state: state,
        );
      },
    ),

  ];
}
