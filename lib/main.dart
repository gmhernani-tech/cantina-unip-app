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
        apiKey: "AIzaSyABxQg4Wkeph8ziPrl6aRfTHgG_ijCx9vU",
        authDomain: "cantina-unip-app.firebaseapp.com",
        projectId: "cantina-unip-app",
        storageBucket: "cantina-unip-app.firebasestorage.app",
        messagingSenderId: "884168519458",
        appId: "1:884168519458:web:7f45db6341eaefbc37bf7b"  
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