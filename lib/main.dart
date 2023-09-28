import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_study/core/injection_container.dart';
import 'package:mvvm_study/todo/store/todo.dart';
import 'package:mvvm_study/todo/views/todo.dart';
import 'package:mvvm_study/ye/stores/quotes.dart';
import 'package:mvvm_study/ye/views/quotes.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionContainer.init();
  await InjectionContainer.sl.allReady();
  await dotenv.load(fileName: '.env.local');
  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['SENTRY_DSN'];
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => InjectionContainer.sl<QuotesStore>()),
        Provider(create: (context) => InjectionContainer.sl<TodoStore>()),
      ],
      child: MaterialApp(
        title: 'flutter_mvvm',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController controller;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    controller = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const [
          Text('Todos'),
          Text('Quotes'),
        ][currentPage],
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (page) => setState(() {
          currentPage = page;
        }),
        children: const [
          TodosView(),
          QuotesView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (page) {
          controller.animateToPage(
            page,
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceInOut,
          );
          setState(() {
            currentPage = page;
          });
        },
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_rounded),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Quotes',
          ),
        ],
      ),
    );
  }
}
