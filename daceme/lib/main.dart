import 'package:daceme/utils/apptheme.dart';
import 'package:daceme/utils/mapping_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main/mainscreen.dart';

void main() {
  // Ensure that the fonts are loaded
  GoogleFonts.config.allowRuntimeFetching = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice Me',
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const DiceMeScreen(),
        '/mapping': (context) => const MappingView(),
      },
    );
  }
}
