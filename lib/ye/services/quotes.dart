import 'package:fpdart/fpdart.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/ye/models/quote.dart';

abstract class QuotesService {
  TaskEither<Failure, Quote> getRandom();
  TaskEither<Failure, Quote> getFromStorage();
}
