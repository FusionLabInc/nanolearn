import 'package:frontend/features/customers/index.dart';

/// Defines a contract/template for classes impelementing the [CustomersDataSource].
abstract class CustomersDataSource {
  Future<CustomerResponse> getAllCustomers();
}
