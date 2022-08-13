// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyFloatingActionButton extends StatelessWidget {
  String? title;
  Color? textColor;
  Color? backgroundColor;
  double? fontSize;
  IconData? icon;
  TextAlign? textAlign;
  Color? iconColor;
  VoidCallback? onPressed;

  MyFloatingActionButton({
    Key? key,
    this.title = "page\n1",
    this.textColor,
    this.fontSize,
    this.textAlign,
    this.backgroundColor,
    this.icon,
    this.iconColor,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
          backgroundColor: backgroundColor,
          onPressed: onPressed,
          child: icon == null
              ? Text(
                  "$title",
                  textAlign: textAlign,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                  ),
                )
              : Icon(
                  icon,
                  color: iconColor,
                ));
  
  }
}
