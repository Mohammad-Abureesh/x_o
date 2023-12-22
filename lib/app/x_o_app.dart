import 'package:flutter/material.dart';

import '../controllers/game_settings.dart';
import '../models/game_mode.dart';
import '../widgets/text_widget.dart';
import 'x_o_board.dart';

class XOApp extends StatelessWidget {
  const XOApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onSelect(String value) {
      selectedUserOption = value;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => XOGameView()));
    }

    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            const TextWidget.bold(data: 'Select Player To Start Game'),
            const SizedBox(height: 30.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['X', 'O']
                    .map((e) => _ActionButton(
                          value: e,
                          onTap: () => onSelect(e),
                        ))
                    .toList()),
            const SizedBox(height: 10.0),
            const Divider(),
            const SizedBox(height: 10.0),
            const TextWidget.bold(data: 'Select Game Mode'),
            const SizedBox(height: 30.0),
            const _ModeOptions(),
          ])),
    );
  }
}

class _ActionButton extends OutlinedButton {
  _ActionButton(
      {required VoidCallback onTap, required String value, Color? background})
      : super(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(backgroundColor: background),
            child: TextWidget.bold(
                data: value,
                color: background == null ? null : Colors.white,
                size: 20.0));
}

class _ModeOptions extends StatefulWidget {
  const _ModeOptions();
  @override
  State<_ModeOptions> createState() => _ModeOptionsState();
}

class _ModeOptionsState extends State<_ModeOptions> {
  GameMode mode = gameMode;

  void _onSelectMode(GameMode mode) {
    setGameMode(mode);
    this.mode = mode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: GameMode.values
            .map((e) => _ActionButton(
                  value: e.title,
                  background: e == mode ? primary : null,
                  onTap: () {
                    _onSelectMode(e);
                  },
                ))
            .toList());
  }
}
