import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CriarBancoDeQuestoes extends StatefulWidget {
  @override
  _CriarBancoDeQuestoesState createState() => _CriarBancoDeQuestoesState();
}

class _CriarBancoDeQuestoesState extends State<CriarBancoDeQuestoes> {
  final TextEditingController nomeBancoController = TextEditingController();
  List<TextEditingController> perguntaControllers = [];
  int numPerguntas = 0;

  @override
  void dispose() {
    nomeBancoController.dispose();
    for (var controller in perguntaControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void limparCamposPerguntas() {
    for (var controller in perguntaControllers) {
      controller.clear();
    }
  }

  void salvarBancoDeQuestoes() async {
    final nomeBanco = nomeBancoController.text.trim();
    if (nomeBanco.isEmpty || numPerguntas == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Por favor, preencha o nome do banco e defina o número de perguntas.'),
      ));
      return;
    }

    final bancoRef =
        FirebaseFirestore.instance.collection('bancosDeQuestoes').doc();

   
    await bancoRef.set({
      'nomeBanco': nomeBanco,
      'quantidadeDeQuestoes': numPerguntas, 
      'ultimaAtualizacao': FieldValue.serverTimestamp(),
    });

    List<String> perguntas = [];
    for (int i = 0; i < numPerguntas; i++) {
      if (perguntaControllers[i].text.isNotEmpty) {
        perguntas.add(perguntaControllers[i].text.trim()); 
      }
    }

    
    await bancoRef.update({
      'perguntas': perguntas,  
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Banco de questões criado com sucesso!'),
    ));

    limparCamposPerguntas();
    nomeBancoController.clear();
  }

  List<Widget> gerarCamposPerguntas() {
    List<Widget> campos = [];
    for (int i = 0; i < numPerguntas; i++) {
      perguntaControllers.add(TextEditingController());
      campos.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: perguntaControllers[i],
            decoration: InputDecoration(
              labelText: 'Pergunta ${i + 1}',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),
        ),
      );
    }
    return campos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Banco de Questões'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nomeBancoController,
              decoration: InputDecoration(
                labelText: 'Nome do Banco de Questões',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Quantas perguntas terão nesse banco de questões?'),
            DropdownButton<int>(
              value: numPerguntas == 0 ? null : numPerguntas,
              hint: Text('Escolha o número de perguntas'),
              onChanged: (value) {
                setState(() {
                  numPerguntas = value!;
                  perguntaControllers.clear();
                });
              },
              items: [
                DropdownMenuItem<int>(value: 5, child: Text('5 perguntas')),
                DropdownMenuItem<int>(value: 10, child: Text('10 perguntas')),
                DropdownMenuItem<int>(value: 15, child: Text('15 perguntas')),
              ],
            ),
            SizedBox(height: 16),
            ...gerarCamposPerguntas(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: salvarBancoDeQuestoes,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
