import '../../domain/entities/otp_data.dart';

class OtpDataModel {

  final int userTime;
  final int tryCount;
  // final String otp;

  const OtpDataModel({
    // required super.otp,
    required this.tryCount,
    required this.userTime,
  });

  OtpDataModel copyWith({
    int? tryCount,
    // String? otp,
    int? userTime,
  }) =>
    OtpDataModel(
      // otp: otp ?? this.otp,
      tryCount: tryCount ?? this.tryCount,
      userTime: userTime ?? this.userTime,
    );


  factory OtpDataModel.fromMap(Map<String, dynamic> json) {
    return OtpDataModel(
      // otp: json['user_otp'] as String,
      tryCount: int.parse(json['user_try']),
      userTime: int.parse(json['user_time']),
    );
  }

  OtpData toEntity() => OtpData(
    // otp: otp,
    userTime: userTime,
    tryCount: tryCount,
  );

  Map<String, dynamic> toMap() => {
    // 'user_otp': otp,
    'userTime': userTime,
    'user_try': tryCount,
  };
}