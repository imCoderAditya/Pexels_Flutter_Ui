import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pexels_api_flutter_ui/wallpaper.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.black,
    // systemNavigationBarDividerColor: Colors.black
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Wallpaper(),

      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   colorScheme:ColorScheme.fromSwatch(
      //     // primarySwatch: Colors.green
      //   )
      // ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
            color: Colors.black,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
            )),
      ),
      themeMode: ThemeMode.dark,

      // themeMode: ThemeMode.system,
      // themeMode: ThemeMode.light,
    );
  }
}
