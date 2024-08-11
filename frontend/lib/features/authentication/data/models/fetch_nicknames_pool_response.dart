class FetchNicknamesPoolResponse {
  final String? status;

  final String? message;

  final bool? hasError;

  final List<String>? nicknamesPool;

  const FetchNicknamesPoolResponse({
    required this.status,
    required this.message,
    this.hasError = false,
    this.nicknamesPool = const [],
  });

  factory FetchNicknamesPoolResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> tempList =
        (json["data"]["nicknames_pool"] ?? []) as List<dynamic>;

    return FetchNicknamesPoolResponse(
      status: json['status'] as String?,
      message: json['name'] as String?,
      nicknamesPool: tempList.map((dynamic item) => item.toString()).toList(),
    );
  }

  factory FetchNicknamesPoolResponse.hasError() =>
      const FetchNicknamesPoolResponse(
        status: "credits_expired",
        message: "",
        hasError: true,
      );
}
