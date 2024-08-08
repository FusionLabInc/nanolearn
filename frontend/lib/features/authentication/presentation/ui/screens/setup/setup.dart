import 'package:frontend/features/authentication/presentation/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:frontend/core/index.dart';

import 'dart:math' as math;

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  bool _obscureValue = true;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final GlobalKey<FormState> passwordValidatorKey = GlobalKey();

  final ValueNotifier<bool> _signInButtonLoading = ValueNotifier(false);

  final _setupPageformKey = GlobalKey<FormState>();

  void _togglePasswordSufficIcon() {
    setState(() {
      _obscureValue = !_obscureValue;
    });
  }

  void _handleSignIn(AuthenticationCubit bloc) {
    if (_setupPageformKey.currentState!.validate()) {
      bloc.onOtpVerificationSuccessfull = (BuildContext context) {
        bloc.signInLogic().then((value) {
          if (value is bool) {
            Future.delayed(
              const Duration(milliseconds: 2000),
              () {
                locator<NavigationService>().goNamed(
                  homeRoute,
                );
              },
            );
          } else if (value is String) {
            CustomOmAlertDialog.show(
                context, CustomOmAlertDialogType.error, value);

            locator<NavigationService>().goNamed(
              setupRoute,
            );
          }
        });
      };
      locator<NavigationService>().goNamed(otpVerificationRoute,
          queryParameters: {"emailAddress": bloc.signInEmail!});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthenticationCubit>(context);
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
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "We are excited that you want to try out our product \n\n",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                letterSpacing: 0.03.sp,
                                fontSize: 23.0,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    TextSpan(
                      text: "You have access to ",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                letterSpacing: 0.03.sp,
                                fontSize: 23.0,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    TextSpan(
                      text: "Nano ",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                letterSpacing: 0.03.sp,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                              ),
                    ),
                    TextSpan(
                      text: " two of your favourite resources",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                letterSpacing: 0.03.sp,
                                fontSize: 23.0,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.0.h,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomNLSolidButton(
                cColor: AppConstants.appBlack.withOpacity(0.4),
                onPressed: () =>
                    locator<NavigationService>().goNamed(registerRoute),
                isLoading: false,
                fontSize: 20.0,
                textColor: AppConstants.appBlack,
                text: AppConstants.jumpInText,
                buttonColor: AppConstants.appPrimaryColor,
                widthS:
                    ResponsiveWidget.isSmallScreen(context) ? 90.0.w : 25.0.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
