import 'package:fpdart/fpdart.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/quotes/services/quotes.dart';
import 'package:mvvm_study/quotes/models/quote.dart';
import 'package:mvvm_study/quotes/repository/quotes.dart';

class QuotesServiceImpl implements QuotesService {
  final QuotesRepository repository;

  QuotesServiceImpl(this.repository);

  @override
  // In questo caso non c'è altro da fare oltre a recuperare la citazione
  TaskEither<Failure, Quote> getRandom() => repository.getRandom();

  // In questo caso i task either sono concatenati, se il primo dovesse
  // restituire un Left allora il metodo alt associa la computazione al
  // task getFromStorage.
  @override
  TaskEither<Failure, Quote> getFromStorage() =>
      repository.getRandom().alt(() => repository.getFromStorage());

  // Possono essere concatenati n task attraverso n flatMap
  // TaskEither<Failure, Quote> getRandomSaveLocal() =>
  //   repository.getRandom()
  //     .flatMap((r) => repository.operazione1());
  //     .flatMap((r) => repository.operazione2());
  //     .flatMap((r) => repository.operazione3());
  //     .flatMap((r) => repository.operazione3());
  //     .flatMap((r) => repository.operazione5());
}
