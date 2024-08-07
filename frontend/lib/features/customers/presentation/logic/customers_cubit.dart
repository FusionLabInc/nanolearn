import 'package:frontend/core/index.dart';
import 'package:frontend/features/customers/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authentication/presentation/listeners/index.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> implements OnAppStartLazy {
  GetAllCustomers getAllCustomers;

  List<Customer>? allCustmomers;

  CustomersCubit(
    this.getAllCustomers,
  ) : super(CustomersInitial());

  Future<CustomerResponse> getAllCustomersLogic() async {
    final _ = NoParams();
    final response = await getAllCustomers(_);
    return response.maybeWhen(
      success: (data) {
        allCustmomers = (data.customers ?? []);
        return data;
      },
      apiFailure: (exception, _) => CustomerResponse.hasError(
        ApiExceptions.getErrorMessage(exception),
      ),
      orElse: () => CustomerResponse.hasError(
        AppConstants.defaultErrorMessage,
      ),
    );
  }

  @override
  Future<void> onAppStartLazy() async {
    await getAllCustomersLogic();
  }
}
