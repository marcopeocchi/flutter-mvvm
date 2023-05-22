import 'dart:convert';
import 'dart:io';

import 'package:mvvm_study/ye/models/quote.dart';
import 'package:mvvm_study/ye/repository/quotes.dart';

class QuotesRepositoryImpl implements QuotesRepository {
  final HttpClient client;

  const QuotesRepositoryImpl(this.client);

  final _url = 'https://api.kanye.rest/';

  @override
  Future<Quote> getRandom() async {
    // simulated API delay
    await Future.delayed(const Duration(milliseconds: 500));

    final req = await client.getUrl(Uri.parse(_url));
    final res = await req.close();

    final data = await res.transform(utf8.decoder).join();
    final quote = Quote.fromJson(jsonDecode(data));

    return quote;
  }
}
