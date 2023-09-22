import 'package:mobx/mobx.dart';
import 'package:mvvm_study/ye/services/quotes.dart';
import 'package:mvvm_study/ye/models/quote.dart';
import 'package:mvvm_study/core/failure.dart';

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
    quote = null;
  }

  @action
  Future getRandom() async {
    resetState(); // very importante: attiva lo stato di caricamento!
    final either = await _service.getRandom().run();
    either.match(
      (l) => error = l,
      (r) => quote = r,
    );
  }
}
