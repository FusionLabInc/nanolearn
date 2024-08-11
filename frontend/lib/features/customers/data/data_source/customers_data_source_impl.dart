// ignore_for_file: unused_field

import 'package:frontend/core/api/api_client/index.dart';
import 'package:frontend/features/customers/index.dart';

class CustomersDataSourceImpl implements CustomersDataSource {
  static const _getAllCustomersPath = '/v1/customer';
  final NLApiClient _apiClient;
  final String _baseApiUrl;

  CustomersDataSourceImpl(
    this._apiClient,
    this._baseApiUrl,
  );

  @override
  Future<CustomerResponse> getAllCustomers() async {
    final response = await _apiClient.get(
      '$_baseApiUrl$_getAllCustomersPath/all?page=1&count=100',
    );

    return CustomerResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
