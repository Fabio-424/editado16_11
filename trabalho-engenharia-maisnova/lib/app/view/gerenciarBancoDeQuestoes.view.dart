import 'package:flutter/material.dart';
import 'package:engenharia_projeto/app/view/visualizar_bancos_de_questoes.dart';
import 'package:engenharia_projeto/app/view/criar_banco_de_questoes.dart';

class GerenciarBancoDeQuestoes extends StatelessWidget {
  const GerenciarBancoDeQuestoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Banco de Questões'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CriarBancoDeQuestoes()),
                );
              },
              child: Text('Criar Novo Banco de Questões'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
               
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VisualizarBancosDeQuestoes()),
                );
              },
              child: Text('Visualizar Bancos de Questões'),
            ),
          ],
        ),
      ),
    );
  }
}
