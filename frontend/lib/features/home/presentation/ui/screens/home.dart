import 'package:frontend/core/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                  child: CustomNLSolidButton(
                    onPressed: () =>
                        locator<NavigationService>().goNamed(registerRoute),
                    isLoading: false,
                    fontSize: 20.0,
                    textColor: AppConstants.appBlack,
                    text: AppConstants.signUpText,
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
        body: Container(),
      ),
    );
  }
}
