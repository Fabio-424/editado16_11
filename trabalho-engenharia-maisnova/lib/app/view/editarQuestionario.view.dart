import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:engenharia_projeto/app/controller/criarQuestionario.controller.dart';
import 'package:engenharia_projeto/app/models/Questionario.model.dart';

class EditarQuestionario extends StatelessWidget {
  final Questionario questionario;
  final CriarQuestionarioController _controller = Get.put(CriarQuestionarioController());

  EditarQuestionario({required this.questionario}) {
    // Carrega os dados do questionário nos controladores
    _controller.tituloController.text = questionario.titulo;
    _controller.entrevistadorController.text = questionario.entrevistador; 
    _controller.linkQuestionarioController.text = questionario.linkQuestionario;
    _controller.modoAplicacaoController.text = questionario.modoAplicacao;
    _controller.prazoAplicacaoController.text = questionario.prazoAplicacao;
    _controller.prazoExpiracaoController.text = questionario.prazoExpiracao;
    _controller.statusAtividadeController.text = questionario.statusAtividade;
    _controller.statusPublicacao = questionario.statusPublicacao;
    _controller.temaController.text = questionario.tema;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Questionário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller.tituloController,
              decoration: InputDecoration(labelText: 'Título do Questionário'),
            ),
            TextField(
              controller: _controller.entrevistadorController,
              decoration: InputDecoration(labelText: 'Entrevistador'),
            ),
            TextField(
              controller: _controller.linkQuestionarioController,
              decoration: InputDecoration(labelText: 'Link do Questionário'),
            ),
            TextField(
              controller: _controller.modoAplicacaoController,
              decoration: InputDecoration(labelText: 'Modo de Aplicação'),
            ),
            TextField(
              controller: _controller.prazoAplicacaoController,
              decoration: InputDecoration(labelText: 'Prazo de Aplicação'),
            ),
            TextField(
              controller: _controller.prazoExpiracaoController,
              decoration: InputDecoration(labelText: 'Prazo de Expiração'),
            ),
            TextField(
              controller: _controller.statusAtividadeController,
              decoration: InputDecoration(labelText: 'Status da Atividade'),
            ),
            DropdownButtonFormField<bool>(
              value: _controller.statusPublicacao,
              onChanged: (value) {
                if (value != null) {
                  _controller.statusPublicacao = value;
                }
              },
              items: [
                DropdownMenuItem(value: true, child: Text('Publicado')),
                DropdownMenuItem(value: false, child: Text('Não Publicado')),
              ],
              decoration: InputDecoration(labelText: 'Status de Publicação'),
            ),
            TextField(
              controller: _controller.temaController,
              decoration: InputDecoration(labelText: 'Tema'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.updateQuestionario(questionario.id!);
                Get.back(); // Volta para a tela anterior após salvar
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
