import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/multiplication/presentation/pages/quiz_page.dart';

void main() {
  runApp(const ProviderScope(child: MattyApp()));
}

class MattyApp extends StatelessWidget {
  const MattyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matty - Aprende las tablas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        useMaterial3: true,
      ),
      home: const QuizPage(),
    );
  }
}