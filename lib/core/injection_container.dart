import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mvvm_study/todo/repository/todo.dart';
import 'package:mvvm_study/todo/repository/todo_impl.dart';
import 'package:mvvm_study/todo/service/todo.dart';
import 'package:mvvm_study/todo/service/todo_impl.dart';
import 'package:mvvm_study/todo/store/todo.dart';
import 'package:mvvm_study/ye/services/quotes.dart';
import 'package:mvvm_study/ye/services/quotes_impl.dart';
import 'package:mvvm_study/ye/repository/quotes.dart';
import 'package:mvvm_study/ye/repository/quotes_impl.dart';
import 'package:mvvm_study/ye/stores/quotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InjectionContainer {
  static final sl = GetIt.instance;

  static Future<void> init() async {
    sl.registerLazySingletonAsync(() => SharedPreferences.getInstance());
    await sl.isReady<SharedPreferences>();

    sl.registerFactory(() => HttpClient());

    sl.registerLazySingleton<QuotesRepository>(
      () => QuotesRepositoryImpl(client: sl(), preferences: sl()),
    );

    sl.registerLazySingleton<QuotesService>(() => QuotesServiceImpl(sl()));

    sl.registerFactory(() => QuotesStore(sl()));

    sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(sl()));

    sl.registerLazySingleton<TodoService>(() => TodoServiceImpl(sl()));

    sl.registerFactory(() => TodoStore(sl()));
  }
}
