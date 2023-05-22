import 'package:flutter/material.dart';
import 'package:mvvm_study/core/container.dart';
import 'package:mvvm_study/ye/views/quotes.dart';

void main() {
  runApp(const MyApp());
  InjectionContainer.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_mvvm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
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
        title: const Text('Flutter MVVM'),
      ),
      body: const QuotesView(),
    );
  }
}
