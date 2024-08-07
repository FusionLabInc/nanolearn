/// Contains the sensitive and necessary configuration variables needed to run the applicatiom.
class AppConfig {
  /// The backend endpoint base api url.
  final String? baseApiUrl;

  //* dsn from sentry
  final String? sentryDsn;
  final double? sentryTracesSampleRate;

  const AppConfig({
    this.baseApiUrl,
    this.sentryDsn,
    this.sentryTracesSampleRate,
  });
}
