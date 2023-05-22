import 'package:mvvm_study/ye/models/quote.dart';

abstract class QuotesRepository {
  Future<Quote> getRandom();
}
