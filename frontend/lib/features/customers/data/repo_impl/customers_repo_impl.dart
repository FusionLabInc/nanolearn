// ignore_for_file: unused_field

import 'package:frontend/core/index.dart';
import 'package:frontend/features/customers/index.dart';

class CustomersRepoImpl extends CustomersRepo {
  final CustomersDataSource _customerDataSource;
  CustomersRepoImpl(
    this._customerDataSource,
  );

  @override
  Future<ApiResult<CustomerResponse>> getAllCustomers() {
    return apiInterceptor(
      _customerDataSource.getAllCustomers(),
    );
  }
}
