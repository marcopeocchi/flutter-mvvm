import 'package:mobx/mobx.dart';
import 'package:mvvm_study/core/sentry.dart';
import 'package:mvvm_study/quotes/services/quotes.dart';
import 'package:mvvm_study/quotes/models/quote.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'quotes.g.dart';

enum StoreState { initial, loading, loaded }

// La classe QuotesStore ha il compito di popolare lo store reattivo (che verrà
// usato nella fase di costruzione dei widget) e del pattern matching degli
// either/taskEither restituiti dai rispettivi services.
//
// Nella fase di pattern matching è possibile riportare gli errori ad altri
// store o ad un SDK tipo Sentry.

class QuotesStore extends _QuotesStoreBase with _$QuotesStore {
  QuotesStore(super.service);
}

abstract class _QuotesStoreBase with Store {
  final QuotesService _service;

  _QuotesStoreBase(this._service);

  @observable
  Quote? quote;

  @observable
  Failure? error;

  @computed
  StoreState get state {
    if (quote == null) return StoreState.loading;
    return quote!.isEmpty ? StoreState.initial : StoreState.loaded;
  }

  void resetState() {
    error = null;
    quote = null;
  }

  // Per naming convention getRandom ha lo stesso nome dei metodi delle repo e
  // dei service.
  //
  // Il tastkEither del service verrà eseguito ed effettuato un pattern matching
  // nel risultante either:
  // La parte sinistra (l) conterrà l'eventuale errore/eccezione/failure.
  // La parte destra (r) conterrà il dato effettivo.
  //
  // Se presente un errore verrà aggiornato lo store reattivo dell'errore che
  // notificherà i Widget che osservano lo store.
  // L'operazione analoga verrà effettuata con il dato effettivo.
  @action
  Future getRandom() async {
    // Esempio di error reporting
    final transaction = Sentry.startTransaction('getRandom()', 'task');
    resetState();

    final either = await _service.getRandom().run();
    either.match(
      (l) {
        error = l;
        logFailure(l);
      },
      (r) async {
        quote = r;
        await transaction.finish();
      },
    );
  }
}
