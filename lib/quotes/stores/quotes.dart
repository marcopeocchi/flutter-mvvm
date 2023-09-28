import 'package:mobx/mobx.dart';
import 'package:mvvm_study/core/sentry.dart';
import 'package:mvvm_study/quotes/services/quotes.dart';
import 'package:mvvm_study/quotes/models/quote.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'quotes.g.dart';

enum StoreState { initial, loading, loaded }

class QuotesStore extends _QuotesStoreBase with _$QuotesStore {
  QuotesStore(QuotesService service) : super(service);
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

  @action
  Future getRandom() async {
    final transaction = Sentry.startTransaction('getRandom()', 'task');
    resetState();

    final either = await _service.getRandom().run();
    either.fold(
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
