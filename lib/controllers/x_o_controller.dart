import 'package:flutter/foundation.dart';
import 'package:x_o/models/best_move.dart';
import 'package:x_o/models/game_mode.dart';

import '../models/pc_movement.dart';
import '../models/player_entity.dart';
import '../models/random_pc_move.dart';
import 'game_settings.dart';

class GameController with ChangeNotifier {
  GameController._(this.user, this.pc);
  GameController.controlled()
      : this._(
          Player(selectedUserOption),
          Player(selectedPcOption),
        );

  Map<String, List<int>> _gameBoard = {};

  final Player user;
  final Player pc;

  bool gameOver = false;

  ///Use when game mode is [playWithFriend] to switch players
  bool _userTurn = true;

  ///Final message on [gameOver]
  String msg = '';

  ///When has winner should update [activeIndexes]
  ///size must be 3
  List<int> activeIndexes = [];

  List<int> get _userChoices => _gameBoard[user.name] ?? [];
  List<int> get _pcChoices => _gameBoard[pc.name] ?? [];
  List<int> get _allChoices => [..._userChoices, ..._pcChoices];

  void selectUserChoice(int index) {
    if (playWithFriend) {
      bool con = _selectChoice(_userTurn ? user : pc, index);
      _userTurn = !_userTurn;
      if (!con) return;
      notifyListeners();
      return;
    }

    bool con = _selectChoice(user, index);
    if (!con) return;
    notifyListeners();
    Future.delayed(pcTurnDuration).then(_pcChoice);
  }

  void _pcChoice(_) {
    if (gameOver) return;
    final PcMovement? movement = switch (gameMode) {
      GameMode.normal => NormalMove(inputs: _allChoices),
      GameMode.hard => BestMove(
          inputs: _allChoices,
          isUserChoice: _userChoices.contains,
        ),
      _ => null
    };
    if (movement == null) return;
    _selectChoice(pc, movement.move);
  }

  bool get _noWinnerEndGame {
    List<int> all = [..._userChoices, ..._pcChoices];
    return all.length == 9;
  }

  bool _selectChoice(Player player, int index) {
    if (gameOver) return false;
    if (_gameBoard[player.name] == null) {
      _gameBoard[player.name] = <int>[];
    }

    var playerChoices = _choicesFormPlayer(player);

    if (playerChoices.contains(index)) {
      return false;
    }

    //add player choice to game board
    _gameBoard[player.name]!.add(index);
    ({bool isWinner, List<int> value}) hasWinner = _isWinner(
      playerChoices,
    );

    if (_noWinnerEndGame && !hasWinner.isWinner) {
      msg = noWinnerMsg;
      gameOver = true;
      notifyListeners();
      return false;
    }

    if (hasWinner.isWinner) {
      activeIndexes = hasWinner.value;
      gameOver = true;
      player.win();
      msg = winnerMsg(player.name == user.name);
    }
    notifyListeners();
    return true;
  }

  ///Check player choices then return is winner
  ({bool isWinner, List<int> value}) _isWinner(List<int> choices) {
    choices.sort((a, b) => a.compareTo(b));
    var value = allWinnerCases.firstWhere(
        (cases) => cases.every(
              (value) => choices.contains(value),
            ),
        orElse: () => []);

    return (isWinner: value.isNotEmpty, value: value);
  }

  void resetGame() {
    gameOver = false;
    msg = '';
    activeIndexes = [];
    _gameBoard = {};
    notifyListeners();
  }

  bool isAbsent(int index) {
    if (gameOver) return false;
    return !_allChoices.contains(index);
  }

  List<int> _choicesFormPlayer(Player player) {
    if (player.name == user.name) return _userChoices;
    return _pcChoices;
  }

  String valueFromIndex(int index) {
    if (_userChoices.contains(index)) return user.name;
    if (_pcChoices.contains(index)) return pc.name;
    return '🥱';
  }
}
