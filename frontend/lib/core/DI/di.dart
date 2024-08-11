import 'package:frontend/core/index.dart';
import 'package:frontend/features/core/DI/index.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication/DI/index.dart';
import '../../features/overview/DI/index.dart';
import '../../features/customers/DI/index.dart';

final GetIt locator = GetIt.I;

/// Sets up DI for core features.
void setupBaseDI({required NanolearnApiConfig nanolearnApiConfig}) {
  locator.registerLazySingleton(() => Connectivity());
  locator.registerLazySingleton<InternetConnection>(
    () => InternetConnectionImpl(locator()),
  );
  locator.registerSingleton(NLApiClient(nanolearnApiConfig));
  locator.registerSingleton(NLGrpcClient(nanolearnApiConfig));
  locator.registerLazySingleton(() => NavigationService());
}

/// Sets up DI for the whole app based on specific feature dependencies.
void setUpAppLocator() {
  setupBaseDI(
    nanolearnApiConfig: NanolearnApiConfig(
      NLConfig.config.baseApiUrl!,
      NLConfig.config.llmServerUrl!,
      bearerToken: () async {
        try {
          final payload = await FlutterSessionJwt.retrieveToken();
          return payload ?? "";
        } catch (e) {
          return "";
        }
      },
    ),
  );

  setUpAuthenticationDependencies();
  setUpCoreCoreDependencies();
  setUpOverviewCoreDependencies();
  setUpCustomersCoreDependencies();
}
