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

class JankenPage extends StatelessWidget {
  const JankenPage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('じゃんけん'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final myChoice = ref
              .watch(mainViewModelProvider.select((value) => value.myChoice));
          final opponentChoice = ref.watch(
              mainViewModelProvider.select((value) => value.opponentChoice));
          final result =
              ref.watch(mainViewModelProvider.select((value) => value.result));
          final rounds =
              ref.watch(mainViewModelProvider.select((value) => value.rounds));
          final totalWinCount = ref.watch(
              mainViewModelProvider.select((value) => value.totalWinCount));
          return Column(
            children: [
              _commonSpace(),
              _commonTextWidget('${rounds ?? 1}回戦'),
              _commonSpace(),
              _commonTextWidget(result?.str ?? ''),
              _commonSpace(),
              _commonTextWidget(opponentChoice),
              _commonSpace(),
              _commonTextWidget(myChoice),
              _commonSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildJankenButton(GuChokiPa.gu),
                  _buildJankenButton(GuChokiPa.choki),
                  _buildJankenButton(GuChokiPa.pa),
                ],
              ),
              if ((rounds ?? 0) >= 5) ...[
                _commonSpace(),
                _commonTextWidget('最終結果'),
                _commonSpace(),
                _commonTextWidget('$totalWinCount回勝利'),
              ]
            ],
          );
        },
      ),
    );
  }

  Widget _commonTextWidget(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 30),
    );
  }

  Widget _commonSpace() {
    return const SizedBox(height: 20);
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
