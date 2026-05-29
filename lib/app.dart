import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handmade_crafts/views/splash_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handmade Crafts',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        colorSchemeSeed: Colors.redAccent,

        textTheme: GoogleFonts.poppinsTextTheme(),

        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
        ),
      ),

      darkTheme: ThemeData.dark(),

      themeMode: ThemeMode.system,

      home: const SplashView(),
    );
  }
}