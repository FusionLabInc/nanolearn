import 'package:frontend/core/index.dart';
import 'package:frontend/features/customers/data/index.dart';
import 'package:frontend/features/customers/domain/index.dart';

/// Registers Authentication feature dependencies
void setUpCustomersCoreDependencies() {
  // Register usecases dependencies.
  locator.registerLazySingleton(() => GetAllCustomers(locator()));

  // Register repository dependencies.
  locator.registerLazySingleton<CustomersRepo>(
    () => CustomersRepoImpl(
      locator(),
    ),
  );

  // Register datasource dependencies.
  locator.registerLazySingleton<CustomersDataSource>(
    () => CustomersDataSourceImpl(
      locator(),
      OmConfig.config.baseApiUrl!,
    ),
  );
}
