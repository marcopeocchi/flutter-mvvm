import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mvvm_study/ye/controllers/quotes.dart';
import 'package:mvvm_study/ye/controllers/quotes_impl.dart';

class InjectionContainer {
  static final sl = GetIt.instance;

  static void init() {
    sl.registerLazySingleton<QuotesController>(
      () => QuotesControllerImpl(sl()),
    );

    sl.registerLazySingleton<HttpClient>(() => HttpClient());
  }
}
