import 'package:flutter/material.dart';
import 'package:mvvm_study/core/container.dart';
import 'package:mvvm_study/core/widgets/failure.dart';
import 'package:mvvm_study/ye/controllers/quotes.dart';

class QuotesView extends StatefulWidget {
  const QuotesView({super.key});

  @override
  State<QuotesView> createState() => _QuoteState();
}

class _QuoteState extends State<QuotesView> {
  final QuotesController vm = InjectionContainer.sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: StreamBuilder(
            stream: vm.events(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return snapshot.data!.fold(
                  (l) => FailureWidget(failure: l),
                  (r) => r.isEmpty
                      ? const CircularProgressIndicator()
                      : Text(
                          r.quote!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                );
              }
              return const Center(
                child: Text(
                  'Hello!',
                  style: TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => vm.getRandom(),
        tooltip: 'Get quote',
        child: const Icon(Icons.shuffle),
      ),
    );
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }
}
