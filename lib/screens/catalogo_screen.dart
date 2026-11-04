import 'package:flutter/material.dart';
import 'package:cantina_unip_app/screens/pedido_screen.dart';
import 'package:cantina_unip_app/screens/historico_screen.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  List get produtos => const [
        {
          'nome': 'Pão de Queijo Recheado',
          'preco': 'R\$ 8,00',
          'imagem': 'assets/imgs/pao_queijo.png',
        },
        {
          'nome': 'Salgado Assado/Frito',
          'preco': 'R\$ 7,50',
          'imagem': 'assets/imgs/salgados.png',
        },
        {
          'nome': 'Sanduíche Natural',
          'preco': 'R\$ 10,00',
          'imagem': 'assets/imgs/sanduiche.png',
        },
        {
          'nome': 'Sumo Natural / Refrigerante',
          'preco': 'R\$ 6,00',
          'imagem': 'assets/imgs/refresco.png',
        },
        {
          'nome': 'Café Expresso',
          'preco': 'R\$ 4,50',
          'imagem': 'assets/imgs/cafe.png',
        },
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo - Cantina UNIP', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF003366),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Ver Histórico de Pedidos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoricoScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            final produto = produtos[index] as Map<String, String>;
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    produto['imagem']!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  produto['nome']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Preço: ${produto['preco']}'),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFCC00), // Amarelo UNIP
                    foregroundColor: Colors.black87,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PedidoScreen(produtoSelecionado: produto['nome']!),
                      ),
                    );
                  },
                  child: const Text('Pedir'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}