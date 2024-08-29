import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/core/failures.dart';
import 'package:mvvm_study/quotes/models/quote.dart';
import 'package:mvvm_study/quotes/repository/quotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Esempio di repository che recupera dati via API REST
// Tutti i metodi hanno come ritorno nella firma un TaskEither che sarà utile
// per comporre operazioni asincrone ed eventuali gestioni delle eccezioni.
class QuotesRepositoryImpl implements QuotesRepository {
  final HttpClient client;
  final SharedPreferences preferences;

  const QuotesRepositoryImpl({
    required this.client,
    required this.preferences,
  });

  final _url = 'https://api.kanye.rest/';

  // Implementazione concreta del metodo getRandom:
  // L'operazione di recupero dei dati da REST API (_makeRequest) è incapsulato
  // da un helper della classe TaskEither: tryCatch.
  //
  // tryCatch è la rappresentazioni funzionale di un classico blocco try/catch.
  // Se l'operazione _makeRequest dovesse generare un'eccezzione/errore verrà
  // inserito nella parte sinistra dell'either.
  // Se l'operazione avrà successo verrà inserito nella parte destra dell'either.
  //
  // L'operazione, se avrà successo, verrà concatenata con il task di caching
  // (_cacheTask).
  // _cacheTask restituendo a sua volta un TaskEither<Failure, Quote> può essere
  // composto a getRandom.
  @override
  TaskEither<Failure, Quote> getRandom() => TaskEither<Failure, Quote>.tryCatch(
        _makeRequest,
        (error, stackTrace) => FetchFailure(
          error: error,
          stacktrace: stackTrace,
        ),
      ).flatMap((r) => _cacheTask(r));

  Future<Quote> _makeRequest() async {
    // simulated delay
    await Future.delayed(const Duration(milliseconds: 500));

    final req = await client.getUrl(Uri.parse(_url));
    final res = await req.close();

    final data = await res.transform(utf8.decoder).join();
    final quote = Quote.fromJson(jsonDecode(data));

    return quote;
  }

  // ---------------------------------------------------------------------- //
  @override
  TaskEither<Failure, Quote> getFromStorage() => TaskEither.tryCatch(
        () => _fetchLocal(),
        (error, stackTrace) => LocalStorageFailure(
          error: error,
          stacktrace: stackTrace,
        ),
      );

  Future<Quote> _fetchLocal() async {
    final data = preferences.getString("cached");

    if (data == null) {
      throw const CacheMissFailure();
    }

    return Quote.fromJson(jsonDecode(data));
  }

  // ---------------------------------------------------------------------- //
  TaskEither<Failure, Quote> _cacheTask(Quote quote) => TaskEither.tryCatch(
        () => _cache(quote),
        (error, stackTrace) => LocalStorageFailure(
          error: error,
          stacktrace: stackTrace,
        ),
      );

  Future<Quote> _cache(Quote quote) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("cached", jsonEncode(quote.toJson()));

    return quote;
  }
}
