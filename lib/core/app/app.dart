import 'package:flutter/material.dart';
import 'package:makharej_app/features/home/presentation/home_screen.dart';

class MakharejApp extends StatelessWidget {
  const MakharejApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modiriyat E Makharej',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
