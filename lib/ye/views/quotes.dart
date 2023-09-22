import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mvvm_study/core/widgets/failure.dart';
import 'package:mvvm_study/ye/stores/quotes.dart';
import 'package:provider/provider.dart';

class QuotesView extends StatefulWidget {
  const QuotesView({super.key});

  @override
  State<QuotesView> createState() => _QuoteState();
}

class _QuoteState extends State<QuotesView> {
  late QuotesStore store;
  late List<ReactionDisposer> disposers;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = Provider.of<QuotesStore>(context);
    store.getRandom();

    disposers = [
      // reaction(
      //   (functor) => store.quote,
      //   (Quote? posts) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(
      //         duration: Duration(milliseconds: 500),
      //         content: Text('⚙️ Retrieved a quote!'),
      //       ),
      //     );
      //   },
      // ),
      // reaction((functor) => store.error, (Failure? error) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       duration: Duration(milliseconds: 500),
      //       content: Text('an error occurred!'),
      //     ),
      //   );
      // })
    ];
  }

  @override
  void dispose() {
    disposers.map((disposer) => disposer());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Observer(
            builder: (context) {
              if (store.error != null) {
                return FailureWidget(failure: store.error!);
              }
              return switch (store.state) {
                StoreState.initial => const Text('Such empty...'),
                StoreState.loading => const CircularProgressIndicator(),
                StoreState.loaded => Text(
                    store.quote!.quote!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              };
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => store.getRandom(),
        tooltip: 'Get quote',
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}
