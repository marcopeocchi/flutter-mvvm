import 'package:flutter/material.dart';
import 'package:mvvm_study/core/injection_container.dart';
import 'package:mvvm_study/ye/stores/quotes.dart';
import 'package:mvvm_study/ye/views/quotes.dart';
import 'package:provider/provider.dart';

void main() {
  InjectionContainer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => InjectionContainer.sl<QuotesStore>()),
      ],
      child: MaterialApp(
        title: 'flutter_mvvm',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Ye quotes'),
      ),
      body: const QuotesView(),
    );
  }
}
