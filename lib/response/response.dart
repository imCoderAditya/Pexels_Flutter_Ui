import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResponsePage extends StatelessWidget {
  Widget mobile;
  Widget desktop;
  Widget teblate;
  ResponsePage(
      {Key? key,
      required this.mobile,
      required this.desktop,
      required this.teblate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth < 640) {
        return mobile;
      } else if (constraints.maxWidth > 640 && constraints.maxWidth < 800) {
        return teblate;
      } else {
        return mobile;
      }
    }));
  }
}
