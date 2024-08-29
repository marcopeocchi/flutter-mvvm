import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/core/pages/error.dart';
import 'package:mvvm_study/quotes/stores/quotes.dart';
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

    // I reaction reagiscono ad un mutamento dello store.
    // Il primo esempio commentato reagirà ad un mutamento nella proprietà quote
    // dello store.
    // Il secondo esempio reagirà ad un mutamento nella proprietà error.
    disposers = [
      // reaction(
      //   (fn) => store.quote,
      //   (Quote? posts) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(
      //         duration: Duration(milliseconds: 500),
      //         content: Text('⚙️ Retrieved a quote!'),
      //       ),
      //     );
      //   },
      // ),
      reaction((fn) => store.error, (Failure? error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: const Text('An error has occurred!'),
            action: SnackBarAction(
              label: 'More',
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return error != null
                          ? ErrorPage(failure: error)
                          : const SizedBox();
                    },
                  ),
                );
              },
            ),
          ),
        );
      })
    ];
  }

  @override
  void dispose() {
    // I reaction vanno disfatti per rimuovere che vengano triggerati al di
    // fuori del ciclo di vita del Widet.
    disposers.map((disposer) => disposer());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          // Il widget observer effettua il rendering o re-rendering dei widget
          // figli se avviene un mutamento nello store.
          child: Observer(
            builder: (context) {
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
        onPressed: () => store.getRandom(), // scateno l'evento
        tooltip: 'Get quote',
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}
