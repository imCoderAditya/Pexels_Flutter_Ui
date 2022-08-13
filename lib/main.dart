
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pexels_api_flutter_ui/home_page.dart';

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
      home: const HomePage(),

      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   colorScheme:ColorScheme.fromSwatch(
      //     // primarySwatch: Colors.green
      //   )
      // ),
// only for dark 
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.red),
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
