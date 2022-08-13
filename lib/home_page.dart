import 'package:flutter/material.dart';
import 'package:pexels_api_flutter_ui/os/desktop/Desktop.dart';
import 'package:pexels_api_flutter_ui/os/mobile/mobile.dart';
import 'package:pexels_api_flutter_ui/os/tablet/tablet.dart';
import 'package:pexels_api_flutter_ui/response/response.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsePage(
      mobile: const MobileBody(),
      desktop: const DesktopLayout(),
      teblate: const TabletLayout(),
    );
  }
}
