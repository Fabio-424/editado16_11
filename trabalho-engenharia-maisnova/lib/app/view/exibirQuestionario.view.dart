import 'package:flutter/material.dart';
import 'package:engenharia_projeto/app/models/Questionario.model.dart';

class ExibirQuestionario extends StatelessWidget {
  final Questionario questionario;

  ExibirQuestionario({required this.questionario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(questionario.titulo), // Exibe o título como título da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Entrevistador: ${questionario.entrevistador}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Link do Questionário: ${questionario.linkQuestionario}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Modo de Aplicação: ${questionario.modoAplicacao}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Prazo de Aplicação: ${questionario.prazoAplicacao}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Prazo de Expiração: ${questionario.prazoExpiracao}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Status da Atividade: ${questionario.statusAtividade}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Status de Publicação: ${questionario.statusPublicacao}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Tema: ${questionario.tema}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
