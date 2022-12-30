import 'package:flutter/material.dart';
import 'package:flutter_application_1/main_viewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

const result = '勝ち';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: JankenPage(),
    );
  }
}

class JankenPage extends ConsumerWidget {
  const JankenPage({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final myChoice =
        ref.watch(mainViewModelProvider.select((value) => value.myChoice));
    final opponentChoice = ref
        .watch(mainViewModelProvider.select((value) => value.opponentChoice));
    final result =
        ref.watch(mainViewModelProvider.select((value) => value.result));
    return Scaffold(
      appBar: AppBar(
        title: const Text('じゃんけん'),
      ),
      body: Column(
        children: [
          _commonSpace(),
          Text(
            result,
            style: const TextStyle(fontSize: 40),
          ),
          _commonSpace(),
          Text(
            opponentChoice,
            style: const TextStyle(fontSize: 40),
          ),
          _commonSpace(),
          Text(
            myChoice,
            style: const TextStyle(fontSize: 40),
          ),
          _commonSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildJankenButton(GuChokiPa.gu),
              _buildJankenButton(GuChokiPa.choki),
              _buildJankenButton(GuChokiPa.pa),
            ],
          ),
        ],
      ),
    );
  }

  Widget _commonSpace() {
    return const SizedBox(height: 30);
  }

  Widget _buildJankenButton(GuChokiPa myChoice) {
    return Consumer(builder: (context, ref, _) {
      return ElevatedButton(
        onPressed: () {
          ref.read(mainViewModelProvider.notifier).setMyChoice(myChoice);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            myChoice.icon,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      );
    });
  }
}
