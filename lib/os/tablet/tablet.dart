import 'package:flutter/material.dart';
import 'package:pexels_api_flutter_ui/widgets/floatingActionButton.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Tablet"),
      ),
      floatingActionButton: MyFloatingActionButton(
        textAlign: TextAlign.center,
      ),
    );
  }
}
