
class RoutePath {

  static const splash = _Route('splash', '/splash');

  // Routes d'authentication corrigées
  static const signUp = _Route('signUp', '/auth/signup');
  static const signIn = _Route('signIn', '/auth/signIn');
  static const signInOtp = _Route('signInOtp', '/auth/signInOtp');
  static const signupOtp = _Route('signUpOtp', '/auth/signUpOtp');
  static const signIn2 = _Route('signIn2', '/auth/signIn2');
  static const requestReset = _Route('requestReset', '/auth/request-reset');
  static const resetPassword = _Route('resetPassword', '/auth/reset-password/:userKey');
  static const verifyOtp = _Route('verifyOtp', '/auth/verify-otp');
  static const savePin = _Route('savePin', '/auth/save-pin');

  static const codePin = _Route('codePin', '/auth/code-pin');
  static const lockScreenTest = _Route('lockScreenTest', '/auth/lock-screen-test');
  static const familyMember = _Route('familyMember', '/auth/family-member');
  static const account = _Route('account', '/auth/account');


  // Routes principales
  static const home = _Route('home', '/app/home');
  static const notifier = _Route('notifier', '/app/notifier');
  static const profile = _Route('profil', '/app/profil');
  static const updateUser = _Route('update-user', '/app/update-user');
  static const changePassword = _Route('change-password', '/app/change-password');
  static const fields = _Route('fields', '/app/fields');





  static const boardingItems = _Route('boarding-items', '/app/boarding-items');
  static const disembarkingItems = _Route('disembarking-items', '/app/disembarking-items');

  // doctors routes
  static const doctorsDetails = _Route('doctors-details', '/app/doctors-details');
  static const medicalCard = _Route('medical-card', '/app/medical-card');


  // FineCare
  static const fineCare = _Route('fine-care', '/app/fine-care');
  static const findDetails = _Route('find-details', '/app/find-details');
  static const appBooking = _Route('app-booking', '/app/app-booking');
  static const createAppoint = _Route('create-appoint', '/app/app-appoint');
  static const maKing = _Route('making', '/app/making');


  // Rice routes
  static const addRice = _Route('add-rice', '/app/add-rice');
  static const editRice = _Route('edit-rice', '/app/edit-rice');
  static const riceList = _Route('rice-list', '/app/rice-list');
  static const riceDetails = _Route('rice-details', '/app/rice-details');
  static const takeRicePhoto = _Route('take-rice-photo', '/app/take-rice-photo');

  // Vehicle routes
  static const addVehicle = _Route('add-vehicle', '/app/add-vehicle');
  static const editVehicle = _Route('edit-vehicle', '/app/edit-vehicle');
  static const vehicleList = _Route('vehicle-list', '/app/vehicle-list');
  static const vehicleDetails = _Route('vehicle-details', '/app/vehicle-details');
  static const takeVehiclePhoto = _Route('take-vehicle-photo', '/app/take-vehicle-photo');

}



/// Classe interne représentant une route avec son nom et son chemin

class _Route {

  final String name;
  final String path;

  const _Route(this.name, this.path);

  @override
  String toString() => 'Route(name: $name, path: $path)';

}