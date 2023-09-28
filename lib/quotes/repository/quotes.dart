import 'package:fpdart/fpdart.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/quotes/models/quote.dart';

abstract class QuotesRepository {
  TaskEither<Failure, Quote> getRandom();
  TaskEither<Failure, Quote> getFromStorage();
}
