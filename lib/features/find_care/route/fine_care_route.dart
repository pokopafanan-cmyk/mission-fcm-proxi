import 'package:go_router/go_router.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/route_path.dart';
import '../presentation/screens/appointment_booking.dart';
import '../presentation/screens/create_appointement.dart';
import '../presentation/screens/find_care_screen.dart';
import '../presentation/screens/fine_care_delail_screen.dart';
import '../presentation/screens/making_apoint_screen.dart';

class FineCareRoute {

  static List<RouteBase> get routes => [

    // GoRoute(
    //   path: RoutePath.doctorsDetails.path,
    //   name: RoutePath.doctorsDetails.name,
    //   pageBuilder: (context, state) {
    //     // On cast l'objet passé en extra
    //     final doctor = state.extra as ListDoctors;
    //
    //     return AppPage.slide(
    //       child: DoctorDetailsScreen(doctor: doctor),
    //       state: state,
    //     );
    //   },
    // ),

    GoRoute(
      path: RoutePath.fineCare.path,
      name: RoutePath.fineCare.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const FindCareScreen(),
          state: state,
        );
      },
    ),

    GoRoute(
      path: RoutePath.findDetails.path,
      name: RoutePath.findDetails.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const AppointmentsScreen(),
          state: state,
        );
      },
    ),

    GoRoute(
      path: RoutePath.appBooking.path,
      name: RoutePath.appBooking.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const AppointmentBooking(),
          state: state,
        );
      },
    ),

    GoRoute(
      path: RoutePath.createAppoint.path,
      name: RoutePath.createAppoint.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const CreateAppointments(),
          state: state,
        );
      },
    ),

    GoRoute(
      path: RoutePath.maKing.path,
      name: RoutePath.maKing.name,
      pageBuilder: (context, state) {
        return AppPage.slide(
          child: const MakingAnAppointmentScreen(),
          state: state,
        );
      },
    ),

  ];
}
