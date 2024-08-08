// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.label,
    required this.builder,
  });

  final String label;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: builder),
          );
        },
        child: Text(label),
      ),
    );
  }
}

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

  List<String> reportList = [
    "Coding",
    "Music",
    "Travel",
    "Food",
    "Nature",
    "Reading",
    "Writing",
    "Gaming",
    "Cooking",
    "Gardening",
    "Photography",
    "Crafting",
    "Dancing",
    "Collecting",
    "Sports",
    "Soccer",
    "Basketball",
    "Tennis",
    "Swimming",
    "Hiking",
    "Creative",
    "Funny",
    "Adventurous",
    "Intelligent",
    "Calm",
    "Happy",
    "Sad",
    "Angry",
    "Excited",
    "Surprised",
    "Strong",
    "Confident",
    "Shy",
    "Curious",
    "Determined",
    "Cat",
    "Dog",
    "Bird",
    "Wolf",
    "Lion",
    "Forest",
    "Ocean",
    "Mountain",
    "River",
    "Sky",
    "Coffee",
    "Book",
    "Computer",
    "Phone",
    "Car",
    "Love",
    "Hope",
    "Freedom",
    "Peace",
    "Chaos",
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Purple",
    "Buzz",
    "Click",
    "Whisper",
    "Roar",
    "Hum",
    "Star",
    "Moon",
    "Fire",
    "Ice",
    "Dream",
    "Shadow",
    "Light",
    "Storm",
    "Rain",
    "Sun",
    "Earth",
    "Space",
    "Time",
    "Infinity",
    "Mystery",
    "Magic",
    "Power",
    "Energy",
    "Spirit",
    "Soul",
    "Mind",
    "Heart",
    "Life",
    "Death",
    "Truth",
    "Lies",
    "Fear",
    "Courage",
    "Joy",
    "Sadness",
    "Anger",
    "Love",
    "Hate",
    "Hope",
    "Despair"
  ];

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
                height: 80.0.h,
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
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: AppConstants.getWidth(context),
                    height: AppConstants.getAppHeight(context) / 2,
                    child: CustomBridgecardMultipleChoice(
                      choices: reportList,
                      onChanged: (value) {
                        print(value);
                      },
                    )),
              ),
            ],
          )),
    );
  }
}
