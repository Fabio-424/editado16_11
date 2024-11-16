import 'package:engenharia_projeto/app/controller/criarQuestionario.controller.dart';
import 'package:engenharia_projeto/app/view/editarQuestionario.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:engenharia_projeto/app/models/Questionario.model.dart';
import 'package:engenharia_projeto/app/view/exibirQuestionario.view.dart'; // Import da tela de exibir questionário

class GerenciarQuestionarios extends StatelessWidget {
  final CriarQuestionarioController _controller = Get.put(CriarQuestionarioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Questionários'),
      ),
      body: StreamBuilder<List<Questionario>>(
        stream: _controller.readQuestionarios(), // Stream de questionários do Firestore
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar questionários: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final questionarios = snapshot.data ?? [];

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: questionarios.length, // Quantidade de questionários
            itemBuilder: (context, index) {
              final questionario = questionarios[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2c5364), Color.fromARGB(255, 75, 145, 175)], // Cores para o degradê verde escuro
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.insert_drive_file, size: 40, color: Colors.grey),
                    ),
                    title: Text(
                      questionario.titulo,
                      style: const TextStyle(color: Colors.white), // Cor do título
                    ),
                    subtitle: Text(
                      'Entrevistador: ${questionario.entrevistador}',
                      style: const TextStyle(color: Colors.white70), // Cor do subtítulo
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.share, color: Colors.white), // Ícone de compartilhar branco
                          onPressed: () {
                            // Ação de compartilhamento
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.white), // Ícone de editar branco
                          onPressed: () {
                            // Navegar para a página de edição do questionário
                            Get.to(EditarQuestionario(questionario: questionario));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.white), // Ícone de deletar branco
                          onPressed: () {
                            _controller.deleteQuestionario(questionario.id!);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navega para a página de exibição do questionário ao clicar no item
                      Get.to(() => ExibirQuestionario(questionario: questionario));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
