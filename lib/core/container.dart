import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mvvm_study/ye/viewmodels/quotes.dart';
import 'package:mvvm_study/ye/viewmodels/quotes_impl.dart';

class InjectionContainer {
  static final sl = GetIt.instance;

  static void init() {
    sl.registerLazySingleton<QuotesViewmodel>(
      () => QuotesViewmodelImpl(sl()),
    );

    sl.registerLazySingleton<HttpClient>(() => HttpClient());
  }
}
