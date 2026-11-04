import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Pedidos (Cantina)', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF003366),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pedidos')
            .orderBy('dataPedido', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Nenhum pedido efetuado ainda.', style: TextStyle(fontSize: 16)),
            );
          }

          final pedidos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
              final pedido = pedidos[index].data() as Map<String, dynamic>;
              
              final nome = pedido['nomeCliente'] ?? 'Cliente';
              final produto = pedido['produto'] ?? 'Item não especificado';
              final rua = pedido['rua'] ?? '';
              final numero = pedido['numero'] ?? '';
              final pagamento = pedido['pagamento'] ?? '';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF003366),
                    child: Icon(Icons.fastfood, color: Color(0xFFFFCC00)),
                  ),
                  title: Text('$nome - $produto', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Endereço: $rua, $numero\nPagamento: $pagamento'),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}