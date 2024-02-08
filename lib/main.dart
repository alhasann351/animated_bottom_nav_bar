import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'myhomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.amaranthTextTheme(),
        primaryColor: const Color.fromRGBO(119, 82, 254, 1),
      ),
      home: const MyHomePage(),
    );
  }
}
