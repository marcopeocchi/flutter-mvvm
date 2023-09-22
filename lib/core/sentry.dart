import 'package:mvvm_study/core/failure.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Failure logFailure(Failure l) {
  Sentry.captureException(l.error, stackTrace: l.stacktrace);
  return l;
}
