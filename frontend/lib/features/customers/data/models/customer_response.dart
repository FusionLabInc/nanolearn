import 'customer.dart';

class CustomerResponse {
  final String? status;

  final String? message;

  final bool hasError;

  final List<Customer>? customers;

  const CustomerResponse({
    required this.status,
    required this.message,
    this.customers,
    this.hasError = false,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> tempList =
        (json["data"]["customers"] ?? []) as List<dynamic>;

    final List<Customer> customerList = [];

    for (final data in tempList) {
      final customerData = Customer.fromJson(
        data as Map<String, dynamic>,
      );
      customerList.add(customerData);
    }

    return CustomerResponse(
      status: json["status"] as String?,
      message: json["message"] as String?,
      customers: customerList,
    );
  }

  factory CustomerResponse.hasError(String errorMessage) => CustomerResponse(
        status: "failed",
        message: errorMessage,
        hasError: true,
      );
}

class AnalyticsData {
  final int total;
  final Map<String, int> byDay;
  final Map<String, int> byWeek;
  final Map<String, int> byYear;
  final Map<String, int> byMonth;

  AnalyticsData({
    required this.total,
    required this.byDay,
    required this.byWeek,
    required this.byYear,
    required this.byMonth,
  });

  factory AnalyticsData.fromJson(Map<String, dynamic> json) {
    return AnalyticsData(
      total: json['total'],
      byDay: Map<String, int>.from(json['by_day']),
      byWeek: Map<String, int>.from(json['by_week']),
      byYear: Map<String, int>.from(json['by_year']),
      byMonth: Map<String, int>.from(json['by_month']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'by_day': byDay,
      'by_week': byWeek,
      'by_year': byYear,
      'by_month': byMonth,
    };
  }
}
