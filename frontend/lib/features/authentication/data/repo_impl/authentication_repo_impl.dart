import 'package:frontend/core/index.dart';
import 'package:frontend/features/authentication/data/data_source/index.dart';
import 'package:frontend/features/authentication/data/models/index.dart';
import 'package:frontend/features/authentication/domain/index.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/pb/llm.pb.dart';
import 'package:grpc/src/client/common.dart';

class AuthenticationRepoImpl extends AuthenticationRepo {
  final AuthenticationDataSource _authenticationDataSource;
  AuthenticationRepoImpl(
    this._authenticationDataSource,
  );
  @override
  Future<ApiResult<Option<User>>> getSignedInUser() {
    return apiInterceptor(_authenticationDataSource.getSignedInUser());
  }

  @override
  Future<ApiResult<Option<bool>>> sendPasswordResetEmail(
    PostEmailParam params,
  ) {
    return apiInterceptor(
      _authenticationDataSource.sendPasswordResetEmail(params),
    );
  }

  @override
  Future<ApiResult<Option<Unit>>> signIn(
    SignInParam params,
  ) {
    return apiInterceptor(
      _authenticationDataSource.signIn(params),
    );
  }

  @override
  Future<ApiResult<void>> signOut() {
    return apiInterceptor(_authenticationDataSource.signOut());
  }

  @override
  Future<ApiResult<EmailVerificationResponse>> verifyEmail(
    PostEmailParam params,
  ) {
    return apiInterceptor(_authenticationDataSource.verifyEmail(params));
  }

  @override
  Future<ApiResult<FetchNicknamesPoolResponse>> fetchNicknamesPool() {
    return apiInterceptor(_authenticationDataSource.fetchNicknamesPool());
  }

  @override
  Future<ApiResult<Option<bool>>> sendOtp(PostEmailParam params) {
    return apiInterceptor(_authenticationDataSource.sendOtp(params));
  }

  @override
  Future<ApiResult<OtpVerificationResponse>> verifyOtp(VerifyOtpParam params) {
    return apiInterceptor(_authenticationDataSource.verifyOtp(params));
  }

  @override
  ResponseStream<GenerateNicknameResponse> generateNickname(
      GenerateNicknameParam params) {
    return _authenticationDataSource.generateNickname(params);
  }

  @override
  Future<ApiResult<GenerateNicknameV2Response>> generateNicknameV2(
      GenerateNicknameV2Param params) {
    return apiInterceptor(_authenticationDataSource.generateNicknameV2(params));
  }
}
