import 'package:flutter/material.dart';
import 'package:cantina_unip_app/screens/pedido_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cantina UNIP', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF003366), // Azul UNIP
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logotipo local da UNIP (Certifica-te que o caminho no pubspec.yaml está configurado)
            Image.asset(
              'assets/imgs/unip-logo.png',
              height: 90, // Podes ajustar a altura conforme preferires
            ),
            const SizedBox(height: 20),
            const Text(
              'Bem-vindo à Cantina da UNIP!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366), // Azul UNIP para dar harmonia ao texto
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFCC00), // Amarelo UNIP
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PedidoScreen()),
                );
              },
              child: const Text(
                'Fazer Pedido',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}