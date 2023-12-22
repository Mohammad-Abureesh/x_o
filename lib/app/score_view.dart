import 'package:flutter/material.dart';
import 'package:x_o/models/player_entity.dart';
import 'package:x_o/widgets/text_widget.dart';

class ScoreView extends StatelessWidget {
  final Player player;
  const ScoreView(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextWidget.bold(
        data: ' ${player.name}  - ${player.score}', size: 20.0);
  }
}
