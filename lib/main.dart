import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cantina_unip_app/screens/home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    // Inicialização com opções de simulação para ambiente Web/Acadêmico
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDummyKeyForUnipPresentation12345",
        appId: "1:1234567890:web:abcdef123456",
        messagingSenderId: "1234567890",
        projectId: "cantina-unip-app",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003366), // Azul institucional UNIP
          primary: const Color(0xFF003366),
          secondary: const Color(0xFFFFCC00), // Amarelo UNIP
        ),
        scaffoldBackgroundColor: Colors.grey[50],
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}