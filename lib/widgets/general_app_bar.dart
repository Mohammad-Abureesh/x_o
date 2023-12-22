import 'package:flutter/material.dart';

import 'text_widget.dart';

class GeneralAppBar extends AppBar {
  GeneralAppBar({Key? key, String? title, List<Widget>? actions})
      : super(
            key: key,
            title: AppBarTitleText(title: title),
            centerTitle: true,
            actions: actions,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            foregroundColor: Colors.black);
}
