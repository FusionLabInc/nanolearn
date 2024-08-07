part of 'billing_cubit.dart';

abstract class BillingState extends Equatable {
  const BillingState();

  @override
  List<Object> get props => [];
}

class BillingInitial extends BillingState {}

class BillingLoading extends BillingState {}

class BillingLoaded<T> extends BillingState {
  final T data;
  const BillingLoaded({
    required this.data,
  }) : super();
}

class BillingError extends BillingState {
  final String errorMessage;

  const BillingError(this.errorMessage);
}
