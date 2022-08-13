import 'package:flutter/material.dart';
import 'package:pexels_api_flutter_ui/widgets/floatingActionButton.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Desktop"),
      ),
     floatingActionButton: MyFloatingActionButton(textAlign: TextAlign.center,),
    );
  }
}
