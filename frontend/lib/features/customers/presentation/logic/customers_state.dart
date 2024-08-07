part of 'customers_cubit.dart';

abstract class CustomersState extends Equatable {
  const CustomersState();

  @override
  List<Object> get props => [];
}

class CustomersInitial extends CustomersState {}

class CustomersLoading extends CustomersState {}

class CustomersLoaded<T> extends CustomersState {
  final T data;
  const CustomersLoaded({
    required this.data,
  }) : super();
}

class CustomersError extends CustomersState {
  final String errorMessage;

  const CustomersError(this.errorMessage);
}
