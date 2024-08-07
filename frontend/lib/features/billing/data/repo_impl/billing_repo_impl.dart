// ignore_for_file: unused_field

import 'package:frontend/core/api/api_result/api_result.dart';
import 'package:frontend/core/api/interceptors/api_interceptor.dart';
import 'package:frontend/features/billing/data/data_source/billing_data_source.dart';
import 'package:frontend/features/billing/data/models/billing_public_details.dart';
import 'package:frontend/features/billing/data/models/superadmin_public_details.dart';
import 'package:frontend/features/billing/index.dart';

class BillingRepoImpl extends BillingRepo {
  final BillingDataSource _billingDataSource;
  BillingRepoImpl(
    this._billingDataSource,
  );

  @override
  Future<ApiResult<BillingPublicDetails>> getBillingPublicDetails(
    GetBillingPublicDetailsParam params,
  ) {
    return apiInterceptor(
      _billingDataSource.getBillingPublicDetails(params),
    );
  }

  @override
  Future<ApiResult<SuperadminPublicDetails>> getSuperadminPublicDetails(
    GetSuperadminPublicDetailsParam params,
  ) {
    return apiInterceptor(
      _billingDataSource.getSuperadminPublicDetails(params),
    );
  }
}
