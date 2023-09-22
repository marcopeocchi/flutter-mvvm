import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mvvm_study/ye/services/quotes.dart';
import 'package:mvvm_study/ye/services/quotes_impl.dart';
import 'package:mvvm_study/ye/repository/quotes.dart';
import 'package:mvvm_study/ye/repository/quotes_impl.dart';
import 'package:mvvm_study/ye/stores/quotes.dart';

class InjectionContainer {
  static final sl = GetIt.instance;

  static Future<void> init() async {
    sl.registerLazySingleton<QuotesRepository>(
      () => QuotesRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<QuotesService>(
      () => QuotesServiceImpl(sl()),
    );

    sl.registerLazySingleton<QuotesStore>(() => QuotesStore(sl()));

    sl.registerLazySingleton<HttpClient>(() => HttpClient());
  }
}
