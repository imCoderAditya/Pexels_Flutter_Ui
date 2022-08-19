import 'package:flutter/material.dart';
import 'package:pexels_api_flutter_ui/home_page.dart';
import 'package:pexels_api_flutter_ui/os/mobile/search.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   systemNavigationBarIconBrightness: Brightness.dark,
  //   systemNavigationBarColor: Colors.black,
  //   // systemNavigationBarDividerColor: Colors.black
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/': (context) => const HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/search': (context) => const SearchData(),
      },

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
          color: Colors.white,
        ),
        
      ),

// only for dark
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.red),
        appBarTheme: const AppBarTheme(
          color: Colors.black,
        ),
      ),
      // themeMode: ThemeMode.dark
      themeMode: ThemeMode.system,
      // themeMode: ThemeMode.light,
    );
  }
}
