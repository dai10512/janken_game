import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_viewModel.freezed.dart';

final mainViewModelProvider =
    StateNotifierProvider<MainViewModel, MainViewModelState>((ref) {
  return MainViewModel();
});

@freezed
class MainViewModelState with _$MainViewModelState {
  const factory MainViewModelState({
    @Default('') String opponentChoice,
    @Default('') String myChoice,
    Result? result,
    @Default(0) int totalWinCount,
    int? rounds,
  }) = _MainViewModelState;
}

class MainViewModel extends StateNotifier<MainViewModelState> {
  MainViewModel() : super(const MainViewModelState());

  void setMyChoice(GuChokiPa myChoice) {
    final rnd0to2 = Random().nextInt(3);
    final opponentChoice = GuChokiPa.values[rnd0to2];

    final myChoiceIcon = myChoice.icon;
    final opponentChoiceIcon = opponentChoice.icon;

    final winCase1 = myChoiceIcon == '✊' && opponentChoiceIcon == '✌️';
    final winCase2 = myChoiceIcon == '✌️' && opponentChoiceIcon == '✋';
    final winCase3 = myChoiceIcon == '✋' && opponentChoiceIcon == '✊';

    final winCase = winCase1 || winCase2 || winCase3;

    final looseCase1 = myChoiceIcon == '✊' && opponentChoiceIcon == '✋';
    final looseCase2 = myChoiceIcon == '✌️' && opponentChoiceIcon == '✊';
    final looseCase3 = myChoiceIcon == '✋' && opponentChoiceIcon == '✌️';

    final looseCase = looseCase1 || looseCase2 || looseCase3;

    final result = winCase
        ? Result.win
        : looseCase
            ? Result.loose
            : Result.draw;

    int nextRounds;
    int totalWinCount;

    final rounds = state.rounds ?? 0;

    if (rounds >= 5) {
      nextRounds = 1;
      totalWinCount = winCase ? 1 : 0;
    } else {
      nextRounds = rounds + 1;
      totalWinCount = state.totalWinCount + (winCase ? 1 : 0);
    }

    state = state.copyWith(
      myChoice: myChoice.icon,
      opponentChoice: opponentChoice.icon,
      result: result,
      rounds: nextRounds,
      totalWinCount: totalWinCount,
    );
  }
}

enum GuChokiPa {
  gu,
  choki,
  pa,
}

extension GuChokiPaExtension on GuChokiPa {
  static final _icon = {
    GuChokiPa.gu: '✊',
    GuChokiPa.choki: '✌️',
    GuChokiPa.pa: '✋'
  };

  String get icon => _icon[this]!;
}

enum Result {
  win,
  draw,
  loose,
}

extension ResultExtension on Result {
  static final _str = {
    Result.win: '勝ち',
    Result.draw: 'あいこ',
    Result.loose: '負け'
  };

  String get str => _str[this]!;
}
