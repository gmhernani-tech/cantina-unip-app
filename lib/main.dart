import 'package:flutter/material.dart';
import 'package:cantina_unip_app/screens/home_screen.dart'; // <--- Altera para esta linha

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CantinaUnipApp());
}

class CantinaUnipApp extends StatelessWidget {
  const CantinaUnipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cantina UNIP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}