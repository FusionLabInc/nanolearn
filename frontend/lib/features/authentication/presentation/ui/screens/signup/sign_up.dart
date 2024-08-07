import 'package:frontend/features/authentication/presentation/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart'
    as intl_phone_number_input;
import 'package:frontend/core/index.dart';

import 'dart:math' as math;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureValue = true;

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _companyNameFocus = FocusNode();

  final GlobalKey<FormState> passwordValidatorKey = GlobalKey();

  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _pass = TextEditingController();
  final ValueNotifier<List<PasswordValidatorCases>>
      _completedPasswordValidatorCases =
      ValueNotifier<List<PasswordValidatorCases>>([]);

  final List<PasswordValidatorCases> _passwordValidatorCases = [
    PasswordValidatorCases.atLeast8Characters,
    PasswordValidatorCases.atLeastOneNumber,
    PasswordValidatorCases.atLeastALowerCase,
    PasswordValidatorCases.atLeastASymbol,
    PasswordValidatorCases.atLeastAnUppercase,
  ];

  final ValueNotifier<bool> _shouldShowPasswordValidatorHint =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> _signUpButtonLoading = ValueNotifier(false);

  final _signUpPageformKey = GlobalKey<FormState>();

  void _togglePasswordSufficIcon() {
    setState(() {
      _obscureValue = !_obscureValue;
    });
  }

  void addToPasswordValidatorCasesList(
    PasswordValidatorCases passwordValidatorCase,
  ) {
    if (!_completedPasswordValidatorCases.value
        .contains(passwordValidatorCase)) {
      _completedPasswordValidatorCases.value = List.from(
        _completedPasswordValidatorCases.value..add(passwordValidatorCase),
      );
    }
  }

  void removeFromPasswordValidatorCasesList(
    PasswordValidatorCases passwordValidatorCase,
  ) {
    if (_completedPasswordValidatorCases.value
        .contains(passwordValidatorCase)) {
      _completedPasswordValidatorCases.value = List.from(
        _completedPasswordValidatorCases.value..remove(passwordValidatorCase),
      );
    }
  }

  void _handleSignUp(AuthenticationCubit bloc) {
    if (_signUpPageformKey.currentState!.validate()) {
      bloc.onOtpVerificationSuccessfull = (BuildContext context) {
        bloc.registerLogic().then((value) {
          if (value is bool) {
            locator<NavigationService>().goNamed(
              setupRoute,
            );
          } else if (value is String) {
            CustomOmAlertDialog.show(
                context, CustomOmAlertDialogType.error, value);

            locator<NavigationService>().goNamed(
              registerRoute,
            );
          }
        });
      };
      locator<NavigationService>().goNamed(otpVerificationRoute,
          queryParameters: {"emailAddress": bloc.signUpWorkEmailAddress!});
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
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          AppConstants.appLogoImagePath,
                        ),
                      ),
                      SizedBox(
                        width: 0.5.w,
                      ),
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomOmSolidButton(
                      onPressed: () =>
                          locator<NavigationService>().goNamed(setupRoute),
                      isLoading: false,
                      fontSize: 20.0,
                      textColor: AppConstants.appBlack,
                      text: AppConstants.signInText,
                      buttonColor: AppConstants.appPrimaryColor,
                      widthS: ResponsiveWidget.isSmallScreen(context)
                          ? 90.0.w
                          : 25.0.w,
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
                child: Container(
                  height: 709.0,
                  width: 517.0,
                  decoration: BoxDecoration(
                    color: AppConstants.appWhite,
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0.w,
                        vertical: 10.0.h,
                      ),
                      child: Column(
                        children: [
                          Form(
                              key: _signUpPageformKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 16.0.h,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      AppConstants.signUpText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: AppConstants.appBlack,
                                            fontSize: 10.0.sp,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0.h,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      AppConstants.createAnAccountCaptionText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppConstants.appBlack,
                                            fontSize: 5.0.sp,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.0.h,
                                  ),
                                  CustomOmTextFormField(
                                    initialValue: bloc.signUpFirstName,
                                    textInputAction: TextInputAction.done,
                                    labelText: AppConstants.firstNameText,
                                    labelTextFontSize: 5.0.sp,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 5.0.w,
                                    ),
                                    validator: Validators.compose([
                                      Validators.required(
                                        AppConstants
                                            .fieldIsRequiredValidatorString,
                                      ),
                                      Validators.minLength(
                                        AppConstants.defaultUserFirstNameLength,
                                        AppConstants
                                            .invalidFirstNameValidatorString,
                                      ),
                                    ]),
                                    focusNode: _firstNameFocus,
                                    onChanged: (String value) {
                                      bloc.signUpFirstName = value;
                                    },
                                    onFieldSubmitted: (value) => changeFocuNode(
                                      from: _firstNameFocus,
                                      to: _lastNameFocus,
                                      context: context,
                                    ),
                                  ),
                                  CustomOmTextFormField(
                                    initialValue: bloc.signUpLastName,
                                    textInputAction: TextInputAction.done,
                                    labelText: AppConstants.lastNameText,
                                    labelTextFontSize: 5.0.sp,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 5.0.w,
                                    ),
                                    validator: Validators.compose([
                                      Validators.required(
                                        AppConstants
                                            .fieldIsRequiredValidatorString,
                                      ),
                                      Validators.minLength(
                                        AppConstants.defaultUserFirstNameLength,
                                        AppConstants
                                            .invalidFirstNameValidatorString,
                                      ),
                                    ]),
                                    focusNode: _lastNameFocus,
                                    onChanged: (String value) {
                                      bloc.signUpLastName = value;
                                    },
                                    onFieldSubmitted: (value) => changeFocuNode(
                                      from: _lastNameFocus,
                                      to: _companyNameFocus,
                                      context: context,
                                    ),
                                  ),
                                  CustomOmTextFormField(
                                    initialValue: bloc.signUpCompanyName,
                                    textInputAction: TextInputAction.done,
                                    labelText: AppConstants.companyNameText,
                                    labelTextFontSize: 5.0.sp,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 5.0.w,
                                    ),
                                    validator: Validators.compose([
                                      Validators.required(
                                        AppConstants
                                            .fieldIsRequiredValidatorString,
                                      ),
                                      Validators.minLength(
                                        AppConstants.defaultUserFirstNameLength,
                                        AppConstants
                                            .invalidFirstNameValidatorString,
                                      ),
                                    ]),
                                    focusNode: _companyNameFocus,
                                    onChanged: (String value) {
                                      bloc.signUpCompanyName = value;
                                    },
                                    onFieldSubmitted: (value) => changeFocuNode(
                                      from: _companyNameFocus,
                                      to: _emailFocus,
                                      context: context,
                                    ),
                                  ),
                                  CustomOmTextFormField(
                                    initialValue: bloc.signUpWorkEmailAddress,
                                    textInputAction: TextInputAction.done,
                                    labelText: AppConstants.workEmailText,
                                    labelTextFontSize: 5.0.sp,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 5.0.w,
                                    ),
                                    // controller: _emailController,
                                    focusNode: _emailFocus,
                                    inputFormatters: [
                                      // Denies the user from adding a white space
                                      // to the textfield input.
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'\s')),
                                    ],
                                    validator: Validators.compose([
                                      Validators.patternRegExp(
                                        AppConstants.validAppEmailRegex,
                                        AppConstants
                                            .invaidEmailValueValidatorString,
                                      ),
                                    ]),
                                    onFieldSubmitted: (value) {
                                      changeFocuNode(
                                        from: _emailFocus,
                                        to: _phoneNumberFocus,
                                        context: context,
                                      );
                                      // _shouldShowPasswordValidatorHint.value = true;
                                    },
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        bloc.signUpWorkEmailAddress =
                                            value.trim();
                                      }
                                    },
                                  ),
                                  CustomInternationalPhoneInput(
                                    cursorColor: AppConstants.appPrimaryColor,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          fontSize: 5.0.sp,
                                          color: AppConstants.appSecondaryColor,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    countries: const ["US"],
                                    focusNode: _phoneNumberFocus,
                                    labelText: AppConstants.phoneNumberText,
                                    onInputChanged: (PhoneNumber phone) {
                                      bloc.signUpPhonenumber =
                                          phone.phoneNumber;
                                    },
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return '';
                                    //   }
                                    //   return null;
                                    // },
                                    initialValue:
                                        intl_phone_number_input.PhoneNumber(
                                      isoCode: "US",
                                    ),
                                    searchBoxDecoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter your Country",
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 5.sp,
                                            color: AppConstants
                                                .appTextFormFieldHintColor,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    selectorConfig:
                                        const intl_phone_number_input
                                            .SelectorConfig(
                                      selectorType: intl_phone_number_input
                                          .PhoneInputSelectorType.BOTTOM_SHEET,
                                    ),
                                    onInputValidated: (bool value) {},
                                    formatInput: false,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      signed: true,
                                      decimal: true,
                                    ),
                                    inputBorder: const OutlineInputBorder(),
                                    onSaved: (PhoneNumber number) {},
                                    onFieldSubmitted: (value) {
                                      changeFocuNode(
                                        context: context,
                                        from: _phoneNumberFocus,
                                        to: _passwordFocus,
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 40.0.h,
                                  ),
                                  CustomOmTextFormField(
                                    textInputAction: TextInputAction.done,
                                    // controller: _pass,
                                    focusNode: _passwordFocus,
                                    labelText: AppConstants.passwordText,
                                    labelTextFontSize: 5.0.sp,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 5.0.w,
                                    ),
                                    suffixIcon: Transform(
                                      // Flips the icon to look like the one
                                      // we have currently in the design.
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: GestureDetector(
                                        onTap: _togglePasswordSufficIcon,
                                        child: !_obscureValue
                                            ? const CustomOmTexFieldEyeCloseWidget()
                                            : const CustomOmTexFieldEyeOpenWidget(),
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (_completedPasswordValidatorCases
                                              .value.length ==
                                          5) {
                                        return null;
                                      }
                                      if (!_shouldShowPasswordValidatorHint
                                              .value &&
                                          _completedPasswordValidatorCases
                                                  .value.length !=
                                              5) {
                                        return AppConstants
                                            .fieldIsRequiredValidatorString;
                                      }
                                      return "";
                                    },
                                    obscureText: _obscureValue,
                                    onChanged: (String value) {
                                      // We do this to ensure that when we start typing inside the Password TextField, the
                                      // validator pops up in the visible area of the screen so that the user doesn't have to
                                      // finish typing the password and close the keyboard before he realises that there is
                                      // an error.

                                      if (passwordValidatorKey.currentContext !=
                                          null) {
                                        if (value.length == 1) {
                                          Scrollable.ensureVisible(
                                            passwordValidatorKey
                                                .currentContext!,
                                          );
                                        }
                                      } else {
                                        if (value.length == 2) {
                                          Scrollable.ensureVisible(
                                            passwordValidatorKey
                                                .currentContext!,
                                          );
                                        }
                                      }

                                      if (CustomPasswordValidator.minLength(
                                          8, value)) {
                                        addToPasswordValidatorCasesList(
                                          PasswordValidatorCases
                                              .atLeast8Characters,
                                        );
                                      } else {
                                        _shouldShowPasswordValidatorHint.value =
                                            true;
                                        removeFromPasswordValidatorCasesList(
                                          PasswordValidatorCases
                                              .atLeast8Characters,
                                        );
                                      }

                                      if (CustomPasswordValidator.patternRegExp(
                                        AppConstants.atLeastOneNumberRegex,
                                        value,
                                      )) {
                                        _shouldShowPasswordValidatorHint.value =
                                            true;
                                        addToPasswordValidatorCasesList(
                                          PasswordValidatorCases
                                              .atLeastOneNumber,
                                        );
                                      } else {
                                        _shouldShowPasswordValidatorHint.value =
                                            true;
                                        removeFromPasswordValidatorCasesList(
                                          PasswordValidatorCases
                                              .atLeastOneNumber,
                                        );
                                      }

                                      if (CustomPasswordValidator.patternRegExp(
                                        AppConstants.atLeastALowerCaseRegex,
                                        value,
                                      )) {
                                        addToPasswordValidatorCasesList(
                                          PasswordValidatorCases
                                              .atLeastALowerCase,
                                        );
                                      } else {
                                        _shouldShowPasswordValidatorHint.value =
                                            true;
                                        removeFromPasswordValidatorCasesList(
                                          PasswordValidatorCases
                                              .atLeastALowerCase,
                                        );
                                      }

                                      if (CustomPasswordValidator.patternRegExp(
                                        AppConstants.atLeastASymbolRegex,
                                        value,
                                      )) {
                                        addToPasswordValidatorCasesList(
                                          PasswordValidatorCases.atLeastASymbol,
                                        );
                                      } else {
                                        _shouldShowPasswordValidatorHint.value =
                                            true;
                                        removeFromPasswordValidatorCasesList(
                                          PasswordValidatorCases.atLeastASymbol,
                                        );
                                      }

                                      if (CustomPasswordValidator.patternRegExp(
                                        AppConstants.atLeastAnUppercaseRegex,
                                        value,
                                      )) {
                                        addToPasswordValidatorCasesList(
                                          PasswordValidatorCases
                                              .atLeastAnUppercase,
                                        );
                                      } else {
                                        _shouldShowPasswordValidatorHint.value =
                                            true;
                                        removeFromPasswordValidatorCasesList(
                                          PasswordValidatorCases
                                              .atLeastAnUppercase,
                                        );
                                      }
                                      if (_completedPasswordValidatorCases
                                              .value.length ==
                                          5) {
                                        _shouldShowPasswordValidatorHint.value =
                                            false;
                                        bloc.signUpPassword = value.trim();
                                      }
                                    },
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable:
                                        _shouldShowPasswordValidatorHint,
                                    builder: (
                                      BuildContext context,
                                      bool shouldShowPasswordValidatorHintValue,
                                      Widget? child,
                                    ) {
                                      return Visibility(
                                        visible:
                                            shouldShowPasswordValidatorHintValue,
                                        child: Container(
                                          key: passwordValidatorKey,
                                          height: 150.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                            color: AppConstants.appPrimaryColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 10.0.w,
                                                  top: 10.0.h,
                                                  bottom: 14.0.h,
                                                ),
                                                child: Text(
                                                  AppConstants
                                                      .passwordValidatorTitleText,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontSize: 5.0.sp,
                                                        color: AppConstants
                                                            .appSecondaryColor3,
                                                      ),
                                                ),
                                              ),
                                              ValueListenableBuilder(
                                                valueListenable:
                                                    _completedPasswordValidatorCases,
                                                builder: (
                                                  BuildContext context,
                                                  List<PasswordValidatorCases>
                                                      completedPasswordValidatorCasesValue,
                                                  Widget? child,
                                                ) {
                                                  return SizedBox(
                                                    height: 100.h,
                                                    width: double.infinity,
                                                    child: GridView.count(
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 15.0,
                                                      childAspectRatio:
                                                          135.w / 40.h,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      children: List.generate(
                                                        _passwordValidatorCases
                                                            .length,
                                                        (index) =>
                                                            Transform.scale(
                                                          scale: 0.8,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 14.w,
                                                                height: 14.h,
                                                                child: Checkbox(
                                                                  checkColor:
                                                                      AppConstants
                                                                          .appPasswordValidateSuccesss,
                                                                  activeColor:
                                                                      AppConstants
                                                                          .appPasswordValidateSuccesss,
                                                                  value: completedPasswordValidatorCasesValue
                                                                      .contains(
                                                                    _passwordValidatorCases[
                                                                        index],
                                                                  ),
                                                                  shape:
                                                                      const CircleBorder(),
                                                                  side:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 0.5,
                                                                  ),
                                                                  onChanged: (bool?
                                                                      value) {},
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      10.0.w),
                                                              Text(
                                                                _passwordValidatorCaseToString(
                                                                  _passwordValidatorCases[
                                                                      index],
                                                                ),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                      letterSpacing:
                                                                          0.2,
                                                                      color: completedPasswordValidatorCasesValue
                                                                              .contains(
                                                                        _passwordValidatorCases[
                                                                            index],
                                                                      )
                                                                          ? AppConstants
                                                                              .appSecondaryColor
                                                                          : AppConstants
                                                                              .appSecondaryColor3,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          3.5.sp,
                                                                    ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 30.0.h,
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: _signUpButtonLoading,
                                    builder: (
                                      BuildContext context,
                                      bool signUpButtonLoadingValue,
                                      Widget? child,
                                    ) {
                                      return CustomOmSolidButton(
                                        onPressed: () => _handleSignUp(bloc),
                                        isLoading: signUpButtonLoadingValue,
                                        fontSize: 20.0,
                                        textColor: AppConstants.appBlack,
                                        text: AppConstants.signUpText,
                                        buttonColor:
                                            AppConstants.appPrimaryColor,
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 30.0.h,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

String _passwordValidatorCaseToString(
  PasswordValidatorCases passwordValidatorCase,
) {
  if (passwordValidatorCase == PasswordValidatorCases.atLeast8Characters) {
    return AppConstants.atLeast8CharactersPasswordValidatorText;
  } else if (passwordValidatorCase ==
      PasswordValidatorCases.atLeastALowerCase) {
    return AppConstants.atLeastALowerCasePasswordValidatorText;
  } else if (passwordValidatorCase ==
      PasswordValidatorCases.atLeastAnUppercase) {
    return AppConstants.atLeastAnUppercasePasswordValidatorText;
  } else if (passwordValidatorCase == PasswordValidatorCases.atLeastOneNumber) {
    return AppConstants.atLeastOneNumberPasswordValidatorText;
  } else if (passwordValidatorCase == PasswordValidatorCases.atLeastASymbol) {
    return AppConstants.atLeastASymbolPasswordValidatorText;
  }
  return "";
}
