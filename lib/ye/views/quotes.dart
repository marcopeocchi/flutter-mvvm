import 'package:flutter/material.dart';
import 'package:mvvm_study/ye/controllers/quotes.dart';

class Quote extends StatelessWidget {
  final QuotesController controller;
  const Quote({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: controller.events(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return snapshot.data!.fold(
                  (l) => Text(l),
                  (r) => Text(r.quote),
                );
              }
              return const Text('Press the button below');
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            controller.getRandom();
          },
          child: const Text('Ye'),
        )
      ],
    );
  }
}
