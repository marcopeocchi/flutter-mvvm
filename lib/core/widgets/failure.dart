import 'package:flutter/material.dart';
import 'package:mvvm_study/core/failure.dart';

class FailureWidget extends StatelessWidget {
  final Failure failure;
  final bool fullWidth;

  const FailureWidget({
    super.key,
    required this.failure,
    this.fullWidth = false,
  });

  Color mapSeverityToColor(FailureSeverity severity) => switch (severity) {
        FailureSeverity.critical => const Color.fromARGB(255, 218, 97, 89),
        FailureSeverity.high => const Color.fromARGB(255, 255, 175, 56),
        FailureSeverity.low => const Color.fromARGB(214, 234, 208, 12),
      };

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight:
            fullWidth ? double.infinity : MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: mapSeverityToColor(failure.severity),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_rounded,
                color: Colors.black54,
                size: 72,
              ),
              Text(
                failure.type,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  failure.message,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  failure.error.toString(),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  failure.stacktrace.toString(),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
