import 'dart:convert';

class GetSuperadminPublicDetailsParam {
  final String superadminId;

  GetSuperadminPublicDetailsParam({
    required this.superadminId,
  });

  Map<String, dynamic> toMap() {
    return {
      "analytics_id": superadminId,
    };
  }

  String toJson() => json.encode(toMap());

  GetSuperadminPublicDetailsParam copyWith({
    String? superadminId,
  }) {
    return GetSuperadminPublicDetailsParam(
      superadminId: superadminId ?? this.superadminId,
    );
  }
}
