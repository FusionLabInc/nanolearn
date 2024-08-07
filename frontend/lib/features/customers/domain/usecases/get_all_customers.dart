import 'package:frontend/core/index.dart';
import 'package:frontend/features/customers/index.dart';

class GetAllCustomers with UseCases<ApiResult<CustomerResponse>, NoParams> {
  final CustomersRepo customersRepo;
  GetAllCustomers(
    this.customersRepo,
  );

  @override
  Future<ApiResult<CustomerResponse>> call(NoParams params) {
    return customersRepo.getAllCustomers();
  }
}
