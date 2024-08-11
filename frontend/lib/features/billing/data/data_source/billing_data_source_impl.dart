// ignore_for_file: unused_field

import 'package:frontend/core/api/api_client/index.dart';
import 'package:frontend/features/billing/data/index.dart';
import 'package:frontend/features/billing/domain/params/get_billing_public_details_params.dart';
import 'package:frontend/features/billing/domain/params/get_superadmin_public_details_params.dart';

class BillingDataSourceImpl implements BillingDataSource {
  final _getSuperadminPublicDetails = '/v1/superadmin/';
  final _getBillingPublicDetails = '/v1/billing/';

  final NLApiClient _apiClient;
  final String _baseApiUrl;

  BillingDataSourceImpl(
    this._apiClient,
    this._baseApiUrl,
  );

  @override
  Future<SuperadminPublicDetails> getSuperadminPublicDetails(
      GetSuperadminPublicDetailsParam params) async {
    final response = await _apiClient.get(
      '$_baseApiUrl$_getSuperadminPublicDetails',
    );

    final data = response.data;

    final superadminPublicDetails = SuperadminPublicDetails.fromJson(
        data["data"]["superadmin"] as Map<String, dynamic>);
    return superadminPublicDetails;
  }

  @override
  Future<BillingPublicDetails> getBillingPublicDetails(
    GetBillingPublicDetailsParam params,
  ) async {
    final response = await _apiClient.get(
      '$_baseApiUrl$_getBillingPublicDetails',
    );

    final data = response.data;

    final superadminPublicDetails = BillingPublicDetails.fromJson(
        data["data"]["billing"] as Map<String, dynamic>);
    return superadminPublicDetails;
  }
}
