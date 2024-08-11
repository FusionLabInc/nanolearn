import 'package:frontend/core/api/index.dart';
import 'package:frontend/features/authentication/data/index.dart';
import 'package:frontend/features/authentication/domain/params/index.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/pb/llm.pb.dart';
import 'package:grpc/grpc.dart';

/// Defines a contract/template for classes impelementing the [AuthenticationRepo].
abstract class AuthenticationRepo {
  Future<ApiResult<Option<User>>> getSignedInUser();

  Future<ApiResult<Option<Unit>>> signIn(
    SignInParam params,
  );

  Future<ApiResult<Option<bool>>> sendPasswordResetEmail(PostEmailParam params);

  Future<ApiResult<Option<bool>>> sendOtp(PostEmailParam params);

  Future<ApiResult<OtpVerificationResponse>> verifyOtp(VerifyOtpParam params);

  Future<ApiResult<void>> signOut();

  Future<ApiResult<EmailVerificationResponse>> verifyEmail(
    PostEmailParam params,
  );

  Future<ApiResult<FetchNicknamesPoolResponse>> fetchNicknamesPool();

  ResponseStream<GenerateNicknameResponse> generateNickname(
    GenerateNicknameParam params,
  );

  Future<ApiResult<GenerateNicknameV2Response>> generateNicknameV2(
    GenerateNicknameV2Param params,
  );
}
