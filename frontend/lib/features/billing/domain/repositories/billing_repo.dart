import 'package:frontend/core/index.dart';
import 'package:frontend/features/billing/data/models/index.dart';
import 'package:frontend/features/billing/index.dart';

/// Defines a contract/template for classes impelementing the [BillingRepo].
abstract class BillingRepo {
  Future<ApiResult<SuperadminPublicDetails>> getSuperadminPublicDetails(
      GetSuperadminPublicDetailsParam params);
  Future<ApiResult<BillingPublicDetails>> getBillingPublicDetails(
      GetBillingPublicDetailsParam params);
}
