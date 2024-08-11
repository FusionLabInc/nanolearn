import 'dart:convert';

class SignInParam {
  final String? nickname;

  SignInParam({
    this.nickname,
  });

  SignInParam copyWith({
    String? nickname,
  }) {
    return SignInParam(
      nickname: nickname ?? this.nickname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
    };
  }

  String toJson() => json.encode(toMap());
}
