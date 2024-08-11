import 'package:flutter/foundation.dart';

@immutable
class UserDetails {
  final String? username;
  final String? userId;
  final int? createdAt;
  final bool hasError;
  final String? errorMessage;

  const UserDetails({
    this.username,
    this.userId,
    this.createdAt,
    this.errorMessage,
    this.hasError = false,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      username: json['username'] as String?,
      userId: json['user_id'] as String?,
      createdAt: json['created_at'] as int?,
    );
  }

  factory UserDetails.hasError(String errorMessage) {
    return UserDetails(
      hasError: true,
      errorMessage: errorMessage,
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "user_id": userId,
        "created_at": createdAt,
      };

  UserDetails copyWith({
    String? username,
    String? userId,
    int? createdAt,
    String? version,
    String? deviceType,
    String? email,
    String? phoneNumber,
    String? errorMessage,
  }) {
    return UserDetails(
      username: username ?? this.username,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      errorMessage: errorMessage ?? errorMessage,
    );
  }
}
