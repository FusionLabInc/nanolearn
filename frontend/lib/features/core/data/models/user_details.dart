import 'package:flutter/foundation.dart';

import 'contents.dart';

@immutable
class UserDetails {
  final String? username;
  final String? userId;
  final int? createdAt;
  final bool hasError;
  final String? errorMessage;

  final List<Content>? contents;

  const UserDetails({
    this.username,
    this.userId,
    this.createdAt,
    this.errorMessage,
    this.contents,
    this.hasError = false,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    final List<dynamic> tempList =
        (json["user"]["contents"] ?? []) as List<dynamic>;

    final List<Content> contentList = [];

    for (final data in tempList) {
      final cuontentData = Content.fromJson(
        data as Map<String, dynamic>,
      );
      contentList.add(cuontentData);
    }
    return UserDetails(
      username: json["user"]['username'] as String?,
      userId: json["user"]['user_id'] as String?,
      createdAt: json["user"]['created_at'] as int?,
      contents: contentList,
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
