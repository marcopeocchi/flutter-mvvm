import 'package:mvvm_study/core/failure.dart';

class FetchFailure extends Failure {
  const FetchFailure({
    super.type = 'FetchFailure',
    super.message = 'An error occured while fetching data from the server',
    super.severity = FailureSeverity.high,
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
