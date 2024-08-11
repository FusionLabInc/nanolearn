class GenerateNicknameV2Response {
  final String? status;

  final String? message;

  final bool? hasError;

  final String? nickname;

  const GenerateNicknameV2Response({
    required this.status,
    required this.message,
    this.hasError = false,
    this.nickname = "",
  });

  factory GenerateNicknameV2Response.fromJson(Map<String, dynamic> json) {
    return GenerateNicknameV2Response(
      status: json['status'] as String?,
      message: json['name'] as String?,
      nickname: json["data"]['nickname'] as String?,
    );
  }

  factory GenerateNicknameV2Response.hasError() =>
      const GenerateNicknameV2Response(
        status: "",
        message: "",
        hasError: true,
      );
}
