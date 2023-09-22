import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/core/failures.dart';
import 'package:mvvm_study/ye/models/quote.dart';
import 'package:mvvm_study/ye/repository/quotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesRepositoryImpl implements QuotesRepository {
  final HttpClient client;

  const QuotesRepositoryImpl(this.client);

  final _url = 'https://api.kanye.rest/';

  @override
  TaskEither<Failure, Quote> getRandom() => TaskEither.tryCatch(
        () => _makeRequest(),
        (error, stackTrace) => FetchFailure(
          error: error,
          stacktrace: stackTrace.toString(),
        ),
      );

  Future<Quote> _makeRequest() async {
    // simulated API delay
    await Future.delayed(const Duration(milliseconds: 500));

    final req = await client.getUrl(Uri.parse(_url));
    final res = await req.close();

    final data = await res.transform(utf8.decoder).join();
    final quote = Quote.fromJson(jsonDecode(data));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("cached", data);

    return quote;
  }

  // ---------------------------------------------------------------------- //
  @override
  TaskEither<Failure, Quote> getFromStorage() => TaskEither.tryCatch(
        () => _fetchLocal(),
        (error, stackTrace) => SharedPreferenceFailure(
          error: error,
          stacktrace: stackTrace.toString(),
        ),
      );

  Future<Quote> _fetchLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("cached");

    if (data == null) {
      throw "cannot find cached quote";
    }

    return Quote.fromJson(jsonDecode(data));
  }
}
