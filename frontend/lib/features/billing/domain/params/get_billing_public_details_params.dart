import 'dart:convert';

class GetBillingPublicDetailsParam {
  final String billingId;

  GetBillingPublicDetailsParam({
    required this.billingId,
  });

  Map<String, dynamic> toMap() {
    return {
      "analytics_id": billingId,
    };
  }

  String toJson() => json.encode(toMap());

  GetBillingPublicDetailsParam copyWith({
    String? billingId,
  }) {
    return GetBillingPublicDetailsParam(
      billingId: billingId ?? this.billingId,
    );
  }
}
