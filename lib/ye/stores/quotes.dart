import 'package:mobx/mobx.dart';
import 'package:mvvm_study/ye/models/quote.dart';

part 'quotes.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  late Quote quote;

  @action
  void getRandom() {}
}
