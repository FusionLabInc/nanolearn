import 'package:frontend/core/index.dart';
import 'package:frontend/features/billing/data/index.dart';
import 'package:frontend/features/billing/index.dart';

class GetBillingPublicDetails
    with
        UseCases<ApiResult<BillingPublicDetails>,
            GetBillingPublicDetailsParam> {
  final BillingRepo _repo;

  GetBillingPublicDetails(this._repo);

  @override
  Future<ApiResult<BillingPublicDetails>> call(
      GetBillingPublicDetailsParam params) {
    return _repo.getBillingPublicDetails(params);
  }
}
