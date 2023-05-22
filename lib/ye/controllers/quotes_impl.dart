import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mvvm_study/ye/controllers/quotes.dart';
import 'package:mvvm_study/ye/models/quote.dart';

class QuotesControllerImpl implements QuotesController {
  final HttpClient client;

  const QuotesControllerImpl(this.client);
  static final StreamController<Either<String, Quote>> _controller =
      StreamController();

  final _url = 'https://api.kanye.rest/';

  @override
  Future<void> getRandom() async {
    try {
      final req = await client.getUrl(Uri.parse(_url));
      final res = await req.close();

      final data = await res.transform(utf8.decoder).join();
      final quote = Quote.fromJson(jsonDecode(data));

      return _controller.sink.add(Right(quote));
    } catch (e) {
      return _controller.sink.add(Left(e.toString()));
    }
  }

  @override
  Stream<Either<String, Quote>> events() {
    return _controller.stream;
  }

  @override
  void dispose() async {
    return _controller.close();
  }
}
