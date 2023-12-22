import 'package:flutter/material.dart';
import 'package:x_o/app/x_o_app.dart';
import 'package:x_o/controllers/game_settings.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(primaryColor: primary),
        home: const XOApp());
  }
}
