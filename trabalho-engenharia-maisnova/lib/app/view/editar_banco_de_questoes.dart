import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditarBancoDeQuestoes extends StatefulWidget {
  final String bancoId;
  final String nomeBanco;

  EditarBancoDeQuestoes({
    required this.bancoId,
    required this.nomeBanco,
  });

  @override
  _EditarBancoDeQuestoesState createState() => _EditarBancoDeQuestoesState();
}

class _EditarBancoDeQuestoesState extends State<EditarBancoDeQuestoes> {
  final _nomeBancoController = TextEditingController();
  final List<TextEditingController> _perguntasControllers = [];
  String _quantidadeDeQuestoes = '5';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _nomeBancoController.text = widget.nomeBanco;
    _carregarBancoDeQuestoes();
  }

  Future<void> _carregarBancoDeQuestoes() async {
    try {
      final bancoSnapshot = await FirebaseFirestore.instance
          .collection('bancosDeQuestoes')
          .doc(widget.bancoId)
          .get();

      if (bancoSnapshot.exists) {
        final bancoData = bancoSnapshot.data();
        
        final quantidadeDeQuestoesFirebase = bancoData?['quantidadeDeQuestoes'];
        final perguntasSalvas = List<String>.from(bancoData?['perguntas'] ?? []);

        setState(() {
          
          _quantidadeDeQuestoes = quantidadeDeQuestoesFirebase is int
              ? quantidadeDeQuestoesFirebase.toString()
              : quantidadeDeQuestoesFirebase ?? '5';

          _atualizarPerguntas(perguntasSalvas);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar banco de questões: $e')),
      );
    }
  }

  void _atualizarPerguntas(List<String> perguntasSalvas) {
    _perguntasControllers.clear();

    int quantidade = int.parse(_quantidadeDeQuestoes);


    for (int i = 0; i < quantidade; i++) {
      _perguntasControllers.add(
        TextEditingController(
          text: i < perguntasSalvas.length ? perguntasSalvas[i] : '',
        ),
      );
    }
  }

  void _salvarEdicoes() async {
    final nomeBanco = _nomeBancoController.text;
    final perguntas =
        _perguntasControllers.map((controller) => controller.text).toList();

    if (nomeBanco.isNotEmpty && perguntas.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('bancosDeQuestoes')
          .doc(widget.bancoId)
          .update({
        'nomeBanco': nomeBanco,
        'perguntas': perguntas,
        'quantidadeDeQuestoes': _quantidadeDeQuestoes,
        'ultimaAtualizacao': DateTime.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Banco de questões atualizado com sucesso!')),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Banco de Questões'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomeBancoController,
              decoration: InputDecoration(
                labelText: 'Nome do Banco de Questões',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _quantidadeDeQuestoes,
              onChanged: (value) {
                setState(() {
                  _quantidadeDeQuestoes = value!;
                  _atualizarPerguntas([]);  
                });
              },
              items: <String>['5', '10', '15']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            
            if (_isLoading)
              Center(child: CircularProgressIndicator()),
      
            if (!_isLoading)
              ...List.generate(
                int.parse(_quantidadeDeQuestoes),
                (index) => TextField(
                  controller: _perguntasControllers.length > index
                      ? _perguntasControllers[index]
                      : TextEditingController(),
                  decoration: InputDecoration(
                    labelText: 'Pergunta ${index + 1}',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvarEdicoes,
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
