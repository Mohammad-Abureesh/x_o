import 'package:flutter/material.dart';

class AppBarTitleText extends TextWidget {
  const AppBarTitleText({Key? key, double? size, String? title})
      : super.bold(
            key: key,
            data: title ?? '',
            size: size ?? 18.0,
            maxLines: 1,
            overflow: TextOverflow.ellipsis);
}

class TextWidget extends StatelessWidget {
  final String data;

  final Color? color;

  final FontWeight? fontWeight;

  final double? size;

  final int? maxLines;

  final TextOverflow? overflow;

  final TextDecoration? decoration;

  final TextAlign? textAlign;
  const TextWidget(
      {Key? key,
      required this.data,
      this.color,
      this.fontWeight,
      this.size,
      this.maxLines,
      this.overflow,
      this.decoration,
      this.textAlign})
      : super(key: key);

  const TextWidget.bold(
      {Key? key,
      required this.data,
      this.color,
      this.size,
      this.maxLines,
      this.overflow,
      this.decoration,
      this.textAlign})
      : fontWeight = FontWeight.bold,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          decoration: decoration,
          fontSize: size,
          fontWeight: fontWeight),
    );
  }
}
