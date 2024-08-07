import 'dart:convert';

import 'package:frontend/features/authentication/data/index.dart';

/// Defines parameters needed to call the [Register] function on the [AuthenticationDataSource] class.
///
/// The [Register] function registers the user with the fields below.
class RegisterParam {
  final String firstName;

  final String lastName;

  final String workEmailAddress;

  final String companyName;

  final String password;

  final String? phoneNumber;

  final String? deviceType;

  final String? mobileVersion;

  RegisterParam(
      {required this.firstName,
      required this.lastName,
      required this.workEmailAddress,
      required this.companyName,
      required this.password,
      required this.phoneNumber,
      this.deviceType,
      this.mobileVersion});

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'email': workEmailAddress,
      'password': password,
      "company_name": companyName,
      "phone_number": phoneNumber,
      "last_name": lastName,
      "device_type": deviceType,
      "version": mobileVersion,
    };
  }

  String toJson() => json.encode(toMap());

  RegisterParam copyWith({
    String? firstName,
    String? workEmailAddress,
    String? password,
    String? lastName,
    String? phoneNumber,
    String? companyName,
    String? deviceType,
    String? mobileVersion,
  }) {
    return RegisterParam(
      firstName: firstName ?? this.firstName,
      workEmailAddress: workEmailAddress ?? this.workEmailAddress,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      lastName: lastName ?? this.lastName,
      companyName: companyName ?? this.companyName,
      deviceType: deviceType ?? this.deviceType,
      mobileVersion: mobileVersion ?? this.mobileVersion,
    );
  }
}
