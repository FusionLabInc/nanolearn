import 'package:frontend/features/billing/data/index.dart';
import 'package:frontend/features/billing/index.dart';

/// Defines a contract/template for classes impelementing the [BillingDataSource].
abstract class BillingDataSource {
  Future<SuperadminPublicDetails> getSuperadminPublicDetails(
      GetSuperadminPublicDetailsParam params);
  Future<BillingPublicDetails> getBillingPublicDetails(
      GetBillingPublicDetailsParam params);
}
