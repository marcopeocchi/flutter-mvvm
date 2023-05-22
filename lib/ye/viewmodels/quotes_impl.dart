import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/core/failures.dart';
import 'package:mvvm_study/ye/models/quote.dart';
import 'package:mvvm_study/ye/viewmodels/quotes.dart';

class QuotesViewmodelImpl implements QuotesViewmodel {
  final HttpClient client;

  const QuotesViewmodelImpl(this.client);
  static final StreamController<Either<Failure, Quote>> _controller =
      StreamController.broadcast();

  final _url = 'https://api.kanye.rest/';

  @override
  Future<void> getRandom() async {
    try {
      _controller.sink.add(Right(Quote.empty()));

      // simulated API delay
      await Future.delayed(const Duration(milliseconds: 500));

      final req = await client.getUrl(Uri.parse(_url));
      final res = await req.close();

      final data = await res.transform(utf8.decoder).join();
      final quote = Quote.fromJson(jsonDecode(data));

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
