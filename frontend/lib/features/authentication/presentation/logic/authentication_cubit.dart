import 'dart:async';

import 'package:frontend/features/authentication/domain/use_cases/send_otp.dart';
import 'package:frontend/features/authentication/domain/use_cases/verify_otp.dart';
import 'package:bloc/bloc.dart';
import 'package:frontend/core/index.dart';
import 'package:frontend/features/authentication/data/index.dart';
import 'package:frontend/features/authentication/domain/index.dart';
import 'package:frontend/features/authentication/presentation/listeners/index.dart';
import 'package:frontend/pb/llm.pb.dart';
import 'package:frontend/utils/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState>
    implements OnAppLogout {
  GetSignedInUser getSignedInUser;
  SendPasswordResetEmail sendPasswordResetEmail;
  SignIn signIn;
  SignOut signOut;
  VerifyEmail verifyEmail;
  FetchNicknamesPool fetchNicknamesPool;
  SendOtp sendOtp;
  VerifyOtp verifyOtp;
  GenerateNickname generateNickname;
  GenerateNicknameV2 generateNicknameV2;

  //Sign Up Bloc Values
  String? signUpWorkEmailAddress;
  String? signUpFirstName;
  String? signUpLastName;
  String? signUpPassword;
  String? signUpPhonenumber;
  String? signUpCompanyName;

  //Sign In Bloc Values
  String? nickname;
  String? signInPassword;

  //Forgot Password Bloc Values
  String? forgotPasswordEmail;

  List<String>? nicknmaesPool;

  String? generatedNickname;

  Function(BuildContext context)? onOtpVerificationSuccessfull;

  void resetState() {
    signUpWorkEmailAddress = null;
    signUpFirstName = null;
    signUpLastName = null;
    signUpPassword = null;
    signUpPhonenumber = null;
    signUpCompanyName = null;

    nickname = null;
    signInPassword = null;

    forgotPasswordEmail = null;
  }

  /// The auth listeners.
  final authListeners = <String, Object?>{};

  AuthenticationCubit(
    this.getSignedInUser,
    this.sendPasswordResetEmail,
    this.signIn,
    this.signOut,
    this.verifyEmail,
    this.fetchNicknamesPool,
    this.verifyOtp,
    this.sendOtp,
    this.generateNickname,
    this.generateNicknameV2,
  ) : super(AuthenticationInitial());

  void registerAuthListeners(List<Object?> listeners) {
    for (final element in listeners) {
      // generate a unique id for the element
      final id = element.toString().hashCode.toString();

      authListeners[id] = element;
    }
  }

  Future<void> sendOnAppLogoutEvent() {
    final values = authListeners.values
        .whereType<OnAppLogout>()
        .map((e) => e.onAppLogout());

    return Future.wait(values);
  }

  Future<void> sendOnAppStartPriorityEvent() {
    final values = authListeners.values
        .whereType<OnAppStartPriority>()
        .map((e) => e.onAppStartPriority());

    return Future.wait(values);
  }

  Future<void> sendOnAppStartLazyEvent() {
    final values = authListeners.values
        .whereType<OnAppStartLazy>()
        .map((e) => e.onAppStartLazy());

    return Future.wait(values);
  }

  Future getSignedInUserLogic() async {
    final param = NoParams();
    final response = await getSignedInUser(param);
    response.maybeWhen(
      success: (data) => data.fold(
        () => emit(const AuthenticationSuccessful(data: null)),
        (value) => emit(AuthenticationSuccessful<User>(data: value)),
      ),
      apiFailure: (exception, _) =>
          emit(AuthenticationError(ApiExceptions.getErrorMessage(exception))),
      orElse: () =>
          emit(const AuthenticationError(AppConstants.defaultErrorMessage)),
    );
  }

  Future sendPasswordResetEmailLogic() async {
    emit(ForgotPasswordLoading());
    final params = PostEmailParam(emailAddress: forgotPasswordEmail!);
    final response = await sendPasswordResetEmail(params);
    response.maybeWhen(
      success: (data) => data.fold(
        () => emit(const AuthenticationError(AppConstants.defaultErrorMessage)),
        (value) => emit(ForgotPasswordCompleted<bool>(data: value)),
      ),
      apiFailure: (exception, _) =>
          emit(AuthenticationError(ApiExceptions.getErrorMessage(exception))),
      orElse: () =>
          emit(const AuthenticationError(AppConstants.defaultErrorMessage)),
    );
  }

  Future signInLogic() async {
    emit(AuthenticationLoading());
    final params = SignInParam(
      nickname: generatedNickname,
    );
    final response = await signIn(params);
    return response.maybeWhen(
      success: (data) => data.fold(
        () => AppConstants.defaultErrorMessage,
        (value) => true,
      ),
      apiFailure: (exception, _) => ApiExceptions.getErrorMessage(exception),
      orElse: () => AppConstants.defaultErrorMessage,
    );
  }

  Future signOutLogic() async {
    final param = NoParams();
    final response = await signOut(param);
    return response.maybeWhen(
      success: (data) async {
        await sendOnAppLogoutEvent();
        return const AuthenticationSuccessful<void>(data: null);
      },
      apiFailure: (exception, _) =>
          emit(AuthenticationError(ApiExceptions.getErrorMessage(exception))),
      orElse: () =>
          emit(const AuthenticationError(AppConstants.defaultErrorMessage)),
    );
  }

  Future<EmailVerificationResponse> verifyEmailLogic(
    PostEmailParam params,
  ) async {
    final response = await verifyEmail(params);
    return response.maybeWhen(
      success: (data) => data,
      apiFailure: (exception, _) => EmailVerificationResponse.hasError(),
      orElse: () => EmailVerificationResponse.hasError(),
    );
  }

  Future<FetchNicknamesPoolResponse> fetchNicknamesPoolLogic() async {
    final param = NoParams();
    final response = await fetchNicknamesPool(param);
    return response.maybeWhen(
      success: (data) {
        nicknmaesPool = data.nicknamesPool ?? [];
        return data;
      },
      apiFailure: (exception, _) => FetchNicknamesPoolResponse.hasError(),
      orElse: () => FetchNicknamesPoolResponse.hasError(),
    );
  }

  Future<bool> sendOtpLogic(String emailAddress) async {
    final response = await sendOtp(PostEmailParam(emailAddress: emailAddress));
    return response.maybeWhen(
      success: (data) => data.fold(() => false, (data) => data),
      apiFailure: (exception, _) => false,
      orElse: () => false,
    );
  }

  Future<OtpVerificationResponse> verifyOtpLogic(
    String emailAddress,
    int otpCode,
  ) async {
    final response = await verifyOtp(VerifyOtpParam(
      emailAddress: emailAddress,
      otpCode: otpCode,
    ));
    return response.maybeWhen(
      success: (data) => data,
      apiFailure: (exception, _) => OtpVerificationResponse.hasError(
        ApiExceptions.getErrorMessage(exception),
      ),
      orElse: () => OtpVerificationResponse.hasError(
        AppConstants.defaultErrorMessage,
      ),
    );
  }

  ResponseStream<GenerateNicknameResponse> generateNicknameLogic(
    StreamController<GenerateNicknameRequest>
        generatedNicknameRequestStreamController,
  ) {
    return generateNickname(GenerateNicknameParam(
        generatedNicknameRequestStreamController:
            generatedNicknameRequestStreamController));
  }

  Future<GenerateNicknameV2Response> generateNicknameV2Logic(
      GenerateNicknameV2Param param) async {
    final response = await generateNicknameV2(param);
    return response.maybeWhen(
      success: (data) {
        if (data.nickname == null || data.nickname!.isEmpty) {
          return GenerateNicknameV2Response.hasError();
        }

        generatedNickname = data.nickname;

        return data;
      },
      apiFailure: (exception, _) => GenerateNicknameV2Response.hasError(),
      orElse: () => GenerateNicknameV2Response.hasError(),
    );
  }

  @override
  Future<void> onAppLogout() {
    resetState();
    return Future.value();
  }
}
