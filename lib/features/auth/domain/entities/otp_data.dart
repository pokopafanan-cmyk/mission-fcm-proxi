import 'package:equatable/equatable.dart';

class OtpData extends Equatable {

  // final String otp;
  final int tryCount;
  final int userTime;

  const OtpData({
    // required this.otp,
    required this.tryCount,
    required this.userTime,
  });

  @override
  List<Object> get props => [tryCount, userTime];

}