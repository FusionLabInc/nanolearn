import 'package:frontend/core/index.dart';
import 'package:frontend/features/billing/data/index.dart';
import 'package:frontend/features/billing/index.dart';

class GetSuperadminPublicDetails
    with
        UseCases<ApiResult<SuperadminPublicDetails>,
            GetSuperadminPublicDetailsParam> {
  final BillingRepo _repo;

  GetSuperadminPublicDetails(this._repo);

  @override
  Future<ApiResult<SuperadminPublicDetails>> call(
      GetSuperadminPublicDetailsParam params) {
    return _repo.getSuperadminPublicDetails(params);
  }
}
