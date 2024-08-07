import 'package:frontend/core/index.dart';
import 'package:frontend/features/billing/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'billing_state.dart';

class BillingCubit extends Cubit<BillingState> {
  BillingCubit(
    this.getBillingPublicDetails,
    this.getSuperadminDetails,
  ) : super(BillingInitial());

  GetBillingPublicDetails getBillingPublicDetails;
  GetSuperadminPublicDetails getSuperadminDetails;

  Future getSuperadminDetailsLogic(String superadminId) async {
    emit(BillingLoading());
    final response = await getSuperadminDetails(
      GetSuperadminPublicDetailsParam(superadminId: superadminId),
    );
    return response.maybeWhen(
      success: (data) async {
        emit(BillingLoaded(data: data));
        return data;
      },
      apiFailure: (exception, _) =>
          emit(BillingError(ApiExceptions.getErrorMessage(exception))),
      orElse: () => emit(const BillingError(AppConstants.defaultErrorMessage)),
    );
  }

  Future getBillingDetailsLogic(String billingId) async {
    emit(BillingLoading());
    final response = await getBillingPublicDetails(
      GetBillingPublicDetailsParam(billingId: billingId),
    );
    return response.maybeWhen(
      success: (data) async {
        emit(BillingLoaded(data: data));
        return data;
      },
      apiFailure: (exception, _) =>
          emit(BillingError(ApiExceptions.getErrorMessage(exception))),
      orElse: () => emit(const BillingError(AppConstants.defaultErrorMessage)),
    );
  }
}
