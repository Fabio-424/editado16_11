import 'package:engenharia_projeto/app/view/gerenciarBancoDeQuestoes.view.dart';
import 'package:engenharia_projeto/app/view/gerenciarEntrevistadores.view.dart';
import 'package:engenharia_projeto/app/view/criarQuestionario.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/gerenciarQuestionario.view.dart';

//função de pegar o nome do usuário que acessou
final String userName = FirebaseAuth.instance.currentUser?.displayName ?? "Usuário"; 

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seja bem vindo!'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : '', // Mostra a primeira letra do nome
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CriarQuestionario()); // Navega para CriarQuestionario ao clicar no FAB
        },
        child: Image.asset('lib/app/images/mais.png'), // Ícone do "+"
        backgroundColor: const Color(0xFF2c5364),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1, // Aspecto quadrado
              ),
              children: [
                _buildGridTile(
                  'Gerenciar questionários',
                  'lib/app/images/questionario.png',
                  2, // Ocupará duas linhas de altura
                  () {
                    Get.to(GerenciarQuestionarios()); // Página para gerenciar questionários
                  },
                ),
                _buildGridTile(
                  'Gerenciar bancos de questões',
                  'lib/app/images/novo-banco-de-dados.png',
                  1, // Tamanho normal
                  () {
                    Get.to(() => GerenciarBancoDeQuestoes()); // Página para gerenciar bancos de questões
                  },
                ),
                _buildGridTile(
                  'Gerenciar entrevistadores',
                  'lib/app/images/entrevistador.png',
                  1, // Tamanho normal
                  () {
                    Get.to(() => GerenciarEntrevistadores()); // Página para gerenciar entrevistadores
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridTile(String title, String imagePath, int rowSpan, VoidCallback onTap) {
    return AspectRatio(
      aspectRatio: rowSpan == 2 ? 0.5 : 1, // Ajusta a altura com base no rowSpan
      child: GestureDetector(
        onTap: onTap, // Função de navegação específica para cada botão
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF2c5364),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
