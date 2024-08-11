import 'package:frontend/features/authentication/data/models/index.dart';
import 'package:frontend/features/authentication/domain/index.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/pb/llm.pb.dart';
import 'package:grpc/grpc.dart';

/// Defines a contract/template for classes impelementing the [AuthenticationDataSource].
abstract class AuthenticationDataSource {
  Future<Option<User>> getSignedInUser();

  Future<Option<Unit>> signIn(
    SignInParam params,
  );

  Future<EmailVerificationResponse> verifyEmail(PostEmailParam params);

  Future<Option<bool>> sendOtp(PostEmailParam params);

  Future<OtpVerificationResponse> verifyOtp(VerifyOtpParam params);

  Future<Option<bool>> sendPasswordResetEmail(PostEmailParam params);

  Future<FetchNicknamesPoolResponse> fetchNicknamesPool();

  ResponseStream<GenerateNicknameResponse> generateNickname(
    GenerateNicknameParam params,
  );

  Future<GenerateNicknameV2Response> generateNicknameV2(
    GenerateNicknameV2Param params,
  );

  Future<void> signOut();
}
