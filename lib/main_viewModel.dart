import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_viewModel.freezed.dart';

@freezed
class MainViewModelState with _$MainViewModelState {
  const factory MainViewModelState({
    @Default('') String opponentChoice,
    @Default('') String myChoice,
    @Default('') String result,
  }) = _MainViewModelState;
}

final mainViewModelProvider =
    StateNotifierProvider<MainViewModel, MainViewModelState>((ref) {
  return MainViewModel();
});

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
        ? Result.win.str
        : looseCase
            ? Result.loose.str
            : Result.draw.str;

    state = state.copyWith(
      myChoice: myChoice.icon,
      opponentChoice: opponentChoice.icon,
      result: result,
    );
  }
}

enum GuChokiPa {
  gu,
  choki,
  pa,
}

extension GuChokiPaExtention on GuChokiPa {
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

extension ResultExtention on Result {
  static final _str = {
    Result.win: '勝ち',
    Result.draw: 'あいこ',
    Result.loose: '負け'
  };

  String get str => _str[this]!;
}
