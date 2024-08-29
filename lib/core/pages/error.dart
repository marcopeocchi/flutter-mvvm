import 'package:flutter/material.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/core/widgets/failure.dart';

class ErrorPage extends StatelessWidget {
  final Failure failure;

  const ErrorPage({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FailureWidget(
          failure: failure,
          fullWidth: true,
        ),
      ),
    );
  }
}
