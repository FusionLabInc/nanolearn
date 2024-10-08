import 'package:frontend/core/index.dart';
import 'package:frontend/features/authentication/data/index.dart';
import 'package:frontend/features/authentication/domain/index.dart';
import 'package:frontend/features/authentication/domain/use_cases/send_otp.dart';
import 'package:frontend/features/authentication/domain/use_cases/verify_otp.dart';

/// Registers Authentication feature dependencies
void setUpAuthenticationDependencies() {
  // Register usecases dependencies.
  locator.registerLazySingleton(() => GetSignedInUser(locator()));
  locator.registerLazySingleton(() => SendPasswordResetEmail(locator()));
  locator.registerLazySingleton(() => SignIn(locator()));
  locator.registerLazySingleton(() => SignOut(locator()));
  locator.registerLazySingleton(() => VerifyEmail(locator()));
  locator.registerLazySingleton(() => FetchNicknamesPool(locator()));
  locator.registerLazySingleton(() => SendOtp(locator()));
  locator.registerLazySingleton(() => VerifyOtp(locator()));
  locator.registerLazySingleton(() => GenerateNickname(locator()));
  locator.registerLazySingleton(() => GenerateNicknameV2(locator()));

  // Register repository dependencies.
  locator.registerLazySingleton<AuthenticationRepo>(
    () => AuthenticationRepoImpl(
      locator(),
    ),
  );

  // Register datasource dependencies.
  locator.registerLazySingleton<AuthenticationDataSource>(
    () => AuthenticationDataSourceImpl(
      locator(),
      locator(),
      NLConfig.config.baseApiUrl!,
    ),
  );
}
