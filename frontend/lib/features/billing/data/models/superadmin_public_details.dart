import 'package:flutter/foundation.dart';

@immutable
class SuperadminPublicDetails {
  final String? companyName;
  final String? companyLogoUrl;
  final String? companyAccentColor;
  final bool hasError;
  final String? errorMessage;

  const SuperadminPublicDetails({
    this.companyName,
    this.companyLogoUrl,
    this.companyAccentColor,
    this.errorMessage,
    this.hasError = false,
  });

  factory SuperadminPublicDetails.fromJson(Map<String, dynamic> json) {
    return SuperadminPublicDetails(
      companyName: json['company_name'] as String?,
      companyLogoUrl: json['company_logo_url'] as String?,
      companyAccentColor: json['device_type'] as String?,
    );
  }

  factory SuperadminPublicDetails.hasError(String errorMessage) {
    return SuperadminPublicDetails(
      hasError: true,
      errorMessage: errorMessage,
    );
  }

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "company_accent_color": companyAccentColor,
        "company_logo_url": companyLogoUrl,
      };

  SuperadminPublicDetails copyWith({
    String? companyName,
    String? companyLogoUrl,
    String? companyAccentColor,
    String? errorMessage,
  }) {
    return SuperadminPublicDetails(
      companyName: companyName ?? this.companyName,
      companyLogoUrl: companyLogoUrl ?? this.companyLogoUrl,
      companyAccentColor: companyAccentColor ?? this.companyAccentColor,
      errorMessage: errorMessage ?? errorMessage,
    );
  }
}
