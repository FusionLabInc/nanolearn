import 'package:frontend/core/index.dart';
import 'package:frontend/features/authentication/presentation/index.dart';
import 'package:frontend/features/billing/index.dart';
import 'package:frontend/features/overview/presentation/ui/screens/overview.dart';
import 'package:frontend/features/splash_page.dart';
import 'package:go_router/go_router.dart';

import 'om_custom_page_routes.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: locator<NavigationService>().navigatorKey,
  routes: [
    GoRoute(
      path: '/billing',
      name: "BillingRoute",
      pageBuilder: (context, state) {
        return NLCustomPageRoutes.withoutAnimation(
          child: const Billing(),
        );
      },
    ),
    GoRoute(
      path: '/',
      name: homeRoute,
      pageBuilder: (context, state) {
        return NLCustomPageRoutes.withoutAnimation(
          child: const SplashPage(),
        );
      },
    ),
    GoRoute(
      path: '/register',
      name: registerRoute,
      pageBuilder: (context, state) {
        return NLCustomPageRoutes.withoutAnimation(
          child: const SignUpPage(),
        );
      },
    ),
    GoRoute(
      path: '/setup',
      name: setupRoute,
      pageBuilder: (context, state) {
        return NLCustomPageRoutes.withoutAnimation(
          child: const SetupPage(),
        );
      },
    ),
    GoRoute(
      path: '/dashboard',
      name: dashboardRoute,
      pageBuilder: (context, state) {
        return NLCustomPageRoutes.ltrSlideTransition(
          child: const Overview(),
        );
      },
    ),

    // GoRoute(
    //   path: '/onboarding',
    //   name: onboardingRoute,
    //   builder: (context, state) => OnboardingPage(),
    // ),
    // GoRoute(
    //   path: '/register',
    //   name: registerRoute,
    //   builder: (context, state) => const RegistrationIndexPage(),
    // ),
    // GoRoute(
    //   path: '/signIn',
    //   name: setupRoute,
    //   builder: (context, state) => const SignInIndexPage(),
    // ),
    // GoRoute(
    //   path: '/forgotPassword',
    //   name: forgotPasswordRoute,
    //   builder: (context, state) => const ForgotPasswordPage(),
    // ),
    // GoRoute(
    //   path: '/selectLinkingType',
    //   name: selectLinkingTypeRoute,
    //   builder: (context, state) => const SelectLinkingType(),
    // ),
    // GoRoute(
    //   path: '/createVirtualAccount',
    //   name: createVirtualAccountPage,
    //   builder: (context, state) => const CreateVirtualAccountPage(),
    // ),
    // GoRoute(
    //   path: '/linkAccount',
    //   name: linkAccountRoute,
    //   builder: (context, state) {
    //     final args = state.extra as LinkAccountArguments?;
    //     return LinkAccount(
    //       shouldShowDialog: args?.shouldShowDialog ?? true,
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: '/sendCash',
    //   name: sendCashRoute,
    //   builder: (context, state) {
    //     final args = state.extra as SendPaymentSourcePageArguments?;
    //     return SendPaymentSourcePage(
    //       sendAccountInputData: args?.sendAccountInputData,
    //       onSendFunctionalityDone: args?.onSendFunctionalityDone,
    //       currentSendModuleType: args?.currentSendModuleType,
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: '/base',
    //   name: basePageRoute,
    //   builder: (context, state) {
    //     final args = state.extra as AppBaseArguments?;
    //     return AppBase(
    //       passedIndex: args?.passedIndex,
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: '/notification',
    //   name: notificationPageRoute,
    //   builder: (context, state) => const NotificationIndexPage(),
    // ),
    // GoRoute(
    //   path: '/allBills',
    //   name: allBillsPageRoute,
    //   builder: (context, state) => const AllBillsPage(),
    // ),
  ],
);
