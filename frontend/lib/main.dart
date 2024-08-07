import 'dart:async';

import 'package:frontend/core/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/.env.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'app.dart';
// ignore: depend_on_referenced_packages

final config = AppConfig(
  baseApiUrl: environment['BASE_API_URL'] as String?,
  sentryDsn: environment["SENTRY_DSN"] as String?,
  sentryTracesSampleRate: environment["SENTRY_TRACE_SAMPLE_RATE"] as double?,
);

void main() async {
  Provider.debugCheckInvalidValueType = null;
  // set app config
  OmConfig.set(config);
  setUpAppLocator();

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      if (kIsWeb) {
        try {} catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
      if (kReleaseMode) {
        await SentryFlutter.init(
          (options) {
            options.dsn = config.sentryDsn;
            options.environment = environment['ENVIRONMENT'] as String?;
            options.release = environment['SENTRY_RELEASE_NAME'] as String?;
            options.beforeSend = (event, {hint}) {
              if (hint == null || hint is! String) {
                return event;
              }

              return event.copyWith(message: SentryMessage(hint));
            } as BeforeSendCallback?;
          },
        );
      }
      runApp(
        // DevicePreview(
        //   enabled: !kReleaseMode,
        //   builder: (context) => const App(),
        // ),
        const App(),
      );
    },
    (Object error, StackTrace stackTrace) {
      AppErrorLogger.logError(error, stackTrace);
    },
  );
}
