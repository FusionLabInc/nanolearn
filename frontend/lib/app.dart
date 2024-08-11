import 'package:frontend/core/index.dart';
import 'package:frontend/features/customers/index.dart';
import 'package:frontend/features/overview/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:flashy_flushbar/flashy_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'features/authentication/presentation/index.dart';
import 'features/core/presentation/index.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paged_datatable/paged_datatable.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationCubit _authenticationCubit;
  late final OverviewCubit _overviewCubit;
  late final CoreCubit _coreCubit;
  late final CustomersCubit _customersCubit;

  @override
  void initState() {
    usePathUrlStrategy();
    _initializeBlocs();
    super.initState();
  }

  // ignore: unused_element
  void _initializeBlocs() {
    _authenticationCubit = AuthenticationCubit(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    );

    _overviewCubit = OverviewCubit(
      locator(),
    );

    _coreCubit = CoreCubit(
      locator(),
      locator(),
    );

    _customersCubit = CustomersCubit(
      locator(),
    );

    _authenticationCubit.registerAuthListeners([
      _coreCubit,
      _customersCubit,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // return
    // MaterialApp(
    //   // useInheritedMediaQuery: true,
    //   // locale: DevicePreview.locale(context),
    //   debugShowCheckedModeBanner: false,
    //   title: AppConstants.appName,
    //   theme: CustomTheme.lightTheme(context),
    //   home: Container(),
    //   navigatorKey: locator<NavigationService>().navigatorKey,
    //   onGenerateRoute: generateRoute,
    // );

    return MediaQuery(
      data: MediaQueryData.fromView(View.of(context)),
      child: ScreenUtilInit(
        designSize: const Size(
          414,
          896,
        ),
        minTextAdapt: true,
        builder: (context, widget) => MultiProvider(
          providers: [
            BlocProvider(
              create: (_) => _authenticationCubit..fetchNicknamesPoolLogic(),
            ),
            BlocProvider(
              create: (_) => _coreCubit,
            ),
            BlocProvider(
              create: (_) => _overviewCubit,
            ),
            BlocProvider(
              create: (_) => _customersCubit,
            ),
          ],
          child: CustomDismissKeyboardWidget(
            child: Builder(
              builder: (BuildContext context) {
                return MaterialApp.router(
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    PagedDataTableLocalization.delegate
                  ],
                  // useInheritedMediaQuery: true,
                  // locale: DevicePreview.locale(context),
                  builder: FlashyFlushbarProvider.init(),
                  debugShowCheckedModeBanner: false,
                  title: AppConstants.appName,
                  theme: CustomTheme.lightTheme(context),
                  routerDelegate: router.routerDelegate,
                  routeInformationParser: router.routeInformationParser,
                  routeInformationProvider: router.routeInformationProvider,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
