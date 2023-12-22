import 'package:flutter/material.dart';
import 'package:x_o/widgets/text_widget.dart';

const double _fieldHeight = 50.0;

class SubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;

  final double radius;
  final double? fontSize;

  final Color? color;

  const SubmitButton(
      {Key? key,
      this.onPressed,
      this.title,
      this.radius = 8,
      this.fontSize,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (title != null) {
      child = TextWidget(data: title!, color: Colors.white, size: fontSize);
    }

    return ElevatedButton(
        style: ButtonStyle(
          minimumSize: const MaterialStatePropertyAll(
              Size(double.infinity, _fieldHeight)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius))),
          backgroundColor:
              MaterialStatePropertyAll(color ?? Theme.of(context).primaryColor),
        ),
        onPressed: onPressed,
        child: child);
  }
}
