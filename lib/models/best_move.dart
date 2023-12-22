import '../controllers/game_settings.dart';
import 'pc_movement.dart';

const String _emptyMove = ' ';

class BestMove extends PcMovement {
  BestMove({required super.inputs, required this.isUserChoice});

  final bool Function(int index) isUserChoice;
  @override
  int get move => _findBestMove();

  String _boardChoice(bool forPc) {
    return forPc ? selectedPcOption : selectedUserOption;
  }

  ///Generated game board from user & pc movements
  List<String> get _board {
    List<String> board = List.filled(9, _emptyMove);
    for (int index = 0; index < board.length; index++) {
      if (inputs.contains(index)) {
        board[index] = _boardChoice(!isUserChoice(index));
      }
    }
    return board;
  }

  int _findBestMove() {
    final List<String> board = _board;
    int bestScore = -1000;
    int bestMove = -1;

    for (int i = 0; i < board.length; i++) {
      if (board[i] == _emptyMove) {
        board[i] = selectedPcOption;
        int score = _minimax(board, false);
        board[i] = _emptyMove;

        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }

  bool _checkWinner(List<String> board) {
    for (List<int> condition in allWinnerCases) {
      if (board[condition[0]] != _emptyMove &&
          board[condition[0]] == board[condition[1]] &&
          board[condition[1]] == board[condition[2]]) {
        return true;
      }
    }
    return false;
  }

  int _minimax(List<String> board, bool isMaximizing) {
    if (_checkWinner(board)) {
      return isMaximizing ? -1 : 1;
    } else if (!board.contains(_emptyMove)) {
      return 0;
    }

    int bestScore = isMaximizing ? -1000 : 1000;

    for (int i = 0; i < board.length; i++) {
      if (board[i] == _emptyMove) {
        board[i] = _boardChoice(isMaximizing);
        int score = _minimax(board, !isMaximizing);
        board[i] = _emptyMove;

        bestScore = isMaximizing
            ? (score > bestScore ? score : bestScore)
            : (score < bestScore ? score : bestScore);
      }
    }

    return bestScore;
  }
}
