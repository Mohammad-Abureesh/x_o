import 'dart:math';

import 'pc_movement.dart';

class NormalMove extends PcMovement {
  NormalMove({required super.inputs});

  int get _randomChoice {
    final r = Random().nextInt(9) + 1;
    return r;
  }

  @override
  int get move {
    int choice = _randomChoice - 1;
    while (inputs.contains(choice)) {
      choice = _randomChoice - 1;
    }
    return choice;
  }
}
