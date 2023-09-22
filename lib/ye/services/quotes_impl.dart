import 'package:fpdart/fpdart.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/ye/models/quote.dart';
import 'package:mvvm_study/ye/repository/quotes.dart';
import 'package:mvvm_study/ye/services/quotes.dart';

class QuotesServiceImpl implements QuotesService {
  final QuotesRepository repository;

  QuotesServiceImpl(this.repository);

  @override
  TaskEither<Failure, Quote> getRandom() => repository.getRandom();
}
