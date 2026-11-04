import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoScreen extends StatefulWidget {
  const PedidoScreen({super.key});

  @override
  State<PedidoScreen> createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {
  // Controladores para os campos de texto e CEP
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _nomeController = TextEditingController();

  // Variáveis para os seletores (Radio / Checkbox)
  String _tipoPagamento = 'Dinheiro';
  bool _incluirCopo = false;

  bool _isLoadingCep = false;

  // Função para consumir a API ViaCEP
  Future<void> _consultarCep(String cep) async {
    final cepLimpo = cep.replaceAll(RegExp(r'[^0-9]'), '');
    if (cepLimpo.length != 8) return;

    setState(() {
      _isLoadingCep = true;
    });

    try {
      final url = Uri.parse('https://viacep.com.br/ws/$cepLimpo/json/');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('erro')) {
          _mostrarErro('CEP não encontrado.');
        } else {
          setState(() {
            _ruaController.text = data['logradouro'] ?? '';
            _bairroController.text = data['bairro'] ?? '';
            _cidadeController.text = data['localidade'] ?? '';
          });
        }
      }
    } catch (e) {
      _mostrarErro('Erro ao consultar o CEP.');
    } finally {
      setState(() {
        _isLoadingCep = false;
      });
    }
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: const Text('Cantina UNIP', style: TextStyle(color: Colors.white)),
    backgroundColor: const Color(0xFF003366), // Azul UNIP
    iconTheme: const IconThemeData(color: Colors.white),
    ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Aluno / Cliente'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cepController,
                    decoration: const InputDecoration(labelText: 'CEP (Entrega)'),
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _isLoadingCep ? null : () => _consultarCep(_cepController.text),
                  child: _isLoadingCep
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Buscar CEP'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ruaController,
              decoration: const InputDecoration(labelText: 'Rua / Logradouro'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _numeroController,
              decoration: const InputDecoration(labelText: 'Número (Residência)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bairroController,
              decoration: const InputDecoration(labelText: 'Bairro'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            const SizedBox(height: 20),
            const Text('Forma de Pagamento:', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text('Dinheiro'),
              value: 'Dinheiro',
              groupValue: _tipoPagamento,
              onChanged: (value) => setState(() => _tipoPagamento = value!),
            ),
            RadioListTile<String>(
              title: const Text('Cartão (Maquininha na entrega)'),
              value: 'Cartao',
              groupValue: _tipoPagamento,
              onChanged: (value) => setState(() => _tipoPagamento = value!),
            ),
            CheckboxListTile(
              title: const Text('Incluir copo descartável e guardanapos'),
              value: _incluirCopo,
              onChanged: (value) => setState(() => _incluirCopo = value!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFCC00), // Amarelo UNIP
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () async {
                // Validação simples
                if (_nomeController.text.isEmpty || _cepController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, preencha o nome e o CEP!'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }

                try {
                  // Grava os dados na coleção 'pedidos' do Firebase Firestore
                  await FirebaseFirestore.instance.collection('pedidos').add({
                    'nomeCliente': _nomeController.text,
                    'cep': _cepController.text,
                    'rua': _ruaController.text,
                    'numero': _numeroController.text,
                    'bairro': _bairroController.text,
                    'cidade': _cidadeController.text,
                    'pagamento': _tipoPagamento,
                    'incluirCopo': _incluirCopo,
                    'dataPedido': FieldValue.serverTimestamp(),
                  });

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pedido enviado e salvo no Firebase com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Retorna para a tela anterior após salvar
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao salvar no Firebase: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text(
                'Finalizar Pedido',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}