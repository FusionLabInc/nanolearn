// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/DI/index.dart';
import 'package:frontend/core/navigation/index.dart';
import 'package:frontend/features/authentication/domain/index.dart';
import 'package:frontend/features/authentication/presentation/index.dart';
import 'package:frontend/pb/llm.pb.dart';
import 'package:frontend/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final StreamController<GenerateNicknameRequest>
      generatedNicknameRequestStreamController =
      StreamController<GenerateNicknameRequest>();

  final ValueNotifier<List<String>> _selectedNicknamesFromPoolList =
      ValueNotifier(const [""]);

  final ValueNotifier<bool> _signInButtonLoading = ValueNotifier(false);

  void _handleSignIn(AuthenticationCubit bloc) {
    _signInButtonLoading.value = true;
    bloc.signInLogic().then((value) {
      if (value is bool) {
        _signInButtonLoading.value = false;
        Future.delayed(
          const Duration(milliseconds: 2000),
          () {
            locator<NavigationService>().goNamed(
              homeRoute,
            );
          },
        );
      } else if (value is String) {
        _signInButtonLoading.value = false;
        CustomNLAlertDialog.show(context, CustomNLAlertDialogType.error, value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final coreBloc = BlocProvider.of<AuthenticationCubit>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppConstants.appPrimaryColor.withOpacity(0.4),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(
              80.0,
            ),
            child: Container(
              width: AppConstants.getWidth(context),
              height: 70.0.h,
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppConstants.appName,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  letterSpacing: 0.03.sp,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w700,
                                ),
                      )
                    ],
                  ),
                  Text(
                    "#JustNanoIt",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 40.0.h,
              ),
              Expanded(
                child: Column(
                  children: [
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Let's get started by selecting your username \n\n",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    letterSpacing: 0.03.sp,
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            TextSpan(
                              text: "Select up to ",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    letterSpacing: 0.03.sp,
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            TextSpan(
                              text: "5",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    letterSpacing: 0.03.sp,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  " words that relate to you and we'd auto-generate a username for you.",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    letterSpacing: 0.03.sp,
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0.h,
              ),
              ValueListenableBuilder(
                valueListenable: _selectedNicknamesFromPoolList,
                builder: (
                  BuildContext context,
                  List<String> selectedNicknamesFromPoolList,
                  Widget? child,
                ) {
                  return FutureBuilder(
                    future: coreBloc.generateNicknameV2Logic(
                      GenerateNicknameV2Param(
                        nicknamesFromPool: selectedNicknamesFromPoolList,
                      ),
                    ),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: coreBloc.generatedNickname ??
                                      AppConstants.nA,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        letterSpacing: 0.03.sp,
                                        fontSize: 23.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Shimmer.fromColors(
                          baseColor: AppConstants.appShimmerBaseColor,
                          highlightColor: AppConstants.appShimmerHighlightColor,
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppConstants.generating,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          letterSpacing: 0.03.sp,
                                          fontSize: 23.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  );
                },
              ),
              SizedBox(
                height: 50.0.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: AppConstants.getWidth(context),
                  height: AppConstants.getAppHeight(context) / 2,
                  child: FutureBuilder(
                    future: coreBloc.fetchNicknamesPoolLogic(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (coreBloc.nicknmaesPool != null) {
                        return CustomBridgecardMultipleChoice(
                          choices: coreBloc.nicknmaesPool!,
                          onChanged: (value) {
                            _selectedNicknamesFromPoolList.value = value;
                          },
                        );
                      }
                      if (snapshot.hasData) {
                        return CustomBridgecardMultipleChoice(
                          choices: coreBloc.nicknmaesPool!,
                          onChanged: (value) {
                            _selectedNicknamesFromPoolList.value = value;
                          },
                        );
                      }

                      return Shimmer.fromColors(
                        baseColor: AppConstants.appShimmerBaseColor,
                        highlightColor: AppConstants.appShimmerHighlightColor,
                        child: CustomBridgecardMultipleChoice(
                          choices: List.generate(100, (_) => "______"),
                          onChanged: (value) {
                            _selectedNicknamesFromPoolList.value = value;
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _signInButtonLoading,
                builder: (
                  BuildContext context,
                  bool signInButtonLoading,
                  Widget? child,
                ) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: CustomNLSolidButton(
                          cColor: AppConstants.appBlack.withOpacity(0.4),
                          onPressed: () => _handleSignIn(coreBloc),
                          isLoading: signInButtonLoading,
                          fontSize: 20.0,
                          textColor: AppConstants.appBlack,
                          text: AppConstants.confirmText,
                          buttonColor: AppConstants.appPrimaryColor,
                          widthS: ResponsiveWidget.isSmallScreen(context)
                              ? 90.0.w
                              : 25.0.w,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          )),
    );
  }
}
