import 'package:flutter/material.dart';

import '../models/game_mode.dart';

/*
   * (0,0),(0,1),(0,2),
   * (1,0),(1,1),(1,2),
   * (2,0),(2,1),(2,2),
   * */
const Set<List<int>> allWinnerCases = {
  //horizontal
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  //vertical
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  //diagonal
  [0, 4, 8],
  [2, 4, 6]
};

const String _initUserOption = 'X';

String selectedUserOption = _initUserOption;

String get selectedPcOption {
  return selectedUserOption == _initUserOption ? 'O' : _initUserOption;
}

///Primary color
const Color primary = Color(0xff6F4BF2);

///Active indexes color [Colors.amberAccent]
const Color winnerColor = Colors.amberAccent;

const Duration pcTurnDuration = Duration(milliseconds: 150);

GameMode gameMode = GameMode.normal;
void setGameMode(GameMode mode) {
  gameMode = mode;
}

bool get playWithFriend => gameMode == GameMode.withOther;

const String noWinnerMsg = 'NO WINNER 😂';

String winnerMsg(bool user) {
  if (playWithFriend) {
    return '${user ? selectedUserOption : selectedPcOption} is Winner 🔥';
  }

  if (user) return 'You Won 😁';
  return 'I won 😎';
}
