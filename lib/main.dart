import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/model/models.dart';
import 'package:provider/provider.dart';
import 'view/pages/pages.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<NewsCategories>(create: (context) => NewsCategories()),
      ChangeNotifierProvider<News>(create: (context) => News()),
    ],
    child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme()
      ),
    );
  }
}
