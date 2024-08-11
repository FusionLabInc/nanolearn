import 'package:frontend/features/authentication/presentation/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/index.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
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
