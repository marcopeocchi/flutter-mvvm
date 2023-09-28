import 'package:mvvm_study/core/failure.dart';

class FetchFailure extends Failure {
  const FetchFailure({
    super.type = 'FetchFailure',
    super.message = 'An error occured while fetching data from the server',
    super.severity = FailureSeverity.critical,
    super.stacktrace = '',
    super.error = '',
  });
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure({
    super.type = 'LocalStorageFailure',
    super.message = 'An error occured while fetching from SharedPreferences',
    super.severity = FailureSeverity.high,
    super.stacktrace = '',
    super.error = '',
  });
}

class CacheMissFailure extends Failure {
  const CacheMissFailure({
    super.type = 'CacheMissFailure',
    super.message = 'A cache key was not found in the store',
    super.severity = FailureSeverity.low,
    super.stacktrace = '',
    super.error = '',
  });
}

class DecodingFailure extends Failure {
  const DecodingFailure({
    super.type = 'DecodingFailure',
    super.message = 'An error occured while decoding response',
    super.severity = FailureSeverity.critical,
    super.stacktrace = '',
    super.error = '',
  });
}
