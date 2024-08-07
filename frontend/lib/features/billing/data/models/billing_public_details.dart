import 'package:flutter/foundation.dart';

@immutable
class BillingPublicDetails {
  final String? billingSecret;
  final String? companyId;
  final String? productId;
  final bool hasError;
  final String? errorMessage;

  const BillingPublicDetails({
    this.billingSecret,
    this.companyId,
    this.productId,
    this.errorMessage,
    this.hasError = false,
  });

  factory BillingPublicDetails.fromJson(Map<String, dynamic> json) {
    return BillingPublicDetails(
      billingSecret: json['billing_secret'] as String?,
      companyId: json['customer_id'] as String?,
      productId: json['product_id'] as String?,
    );
  }

  factory BillingPublicDetails.hasError(String errorMessage) {
    return BillingPublicDetails(
      hasError: true,
      errorMessage: errorMessage,
    );
  }

  Map<String, dynamic> toJson() => {
        "billing_secret": billingSecret,
        "product_id": productId,
        "customer_id": companyId,
      };

  BillingPublicDetails copyWith({
    String? billingSecret,
    String? companyId,
    String? productId,
    String? errorMessage,
  }) {
    return BillingPublicDetails(
      billingSecret: billingSecret ?? this.billingSecret,
      companyId: companyId ?? this.companyId,
      productId: productId ?? this.productId,
      errorMessage: errorMessage ?? errorMessage,
    );
  }
}
