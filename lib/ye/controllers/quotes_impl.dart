import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/core/failures.dart';
import 'package:mvvm_study/ye/controllers/quotes.dart';
import 'package:mvvm_study/ye/models/quote.dart';
import 'package:mvvm_study/ye/repository/quotes.dart';

class QuotesControllerImpl implements QuotesController {
  final QuotesRepository repository;

  const QuotesControllerImpl(this.repository);

  static final StreamController<Either<Failure, Quote>> _controller =
      StreamController.broadcast();

  @override
  Future<void> getRandom() async {
    try {
      _controller.sink.add(Right(Quote.empty()));

      final quote = await repository.getRandom();

      return _controller.sink.add(Right(quote));
    } catch (e) {
      return _controller.sink.add(const Left(FetchFailure()));
    }
  }

  @override
  Stream<Either<Failure, Quote>> events() {
    return _controller.stream.asBroadcastStream();
  }

  @override
  Future<void> dispose() async {
    return _controller.close();
  }
}
