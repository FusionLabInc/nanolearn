import 'package:frontend/core/index.dart';
import 'package:frontend/features/customers/index.dart';

/// Defines a contract/template for classes impelementing the [CustomersRepo].
abstract class CustomersRepo {
  Future<ApiResult<CustomerResponse>> getAllCustomers();
}
