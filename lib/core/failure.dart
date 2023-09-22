import 'package:equatable/equatable.dart';

enum FailureSeverity {
  critical,
  high,
  low,
}

class Failure extends Equatable {
  final String type;
  final String message;
  final FailureSeverity severity;
  final Object? error;
  final String? stacktrace;

  const Failure({
    required this.type,
    required this.message,
    required this.severity,
    this.error,
    this.stacktrace,
  });

  @override
  List<Object?> get props => [
        type,
        message,
        severity,
        error,
        stacktrace,
      ];
}
