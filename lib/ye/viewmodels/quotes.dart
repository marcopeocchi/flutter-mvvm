import 'package:dartz/dartz.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/ye/models/quote.dart';

abstract class QuotesViewmodel {
  Future<void> getRandom();
  Stream<Either<Failure, Quote>> events();
  Future<void> dispose();
}
