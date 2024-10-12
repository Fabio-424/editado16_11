import 'package:engenharia_projeto/app/view/gerenciarBancoDeQuestoes.view.dart';
import 'package:engenharia_projeto/app/view/gerenciarEntrevistadores.view.dart';
import 'package:engenharia_projeto/app/view/gerenciarQuestionario.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/criarQuestionario.view.dart';

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
                'K', // Aqui seria a inicial do usuário
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
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Acesse com seu e-mail institucional',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // Número de colunas
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              children: [
                _buildGridTile(
                  'Gerenciar questionários',
                  'lib/app/images/questionario.png',
                  2, // Ocupará duas linhas de altura
                  () {
                    Get.to(() => GerenciarQuestionario()); // Página para gerenciar questionários
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

  Widget _buildGridTile(String title, String imagePath, int heightMultiplier, VoidCallback onTap) {
    return AspectRatio(
      aspectRatio: 1 / heightMultiplier, // Ajusta a altura com base no multiplicador
      child: GestureDetector(
        onTap: onTap, // Função de navegação específica para cada botão
        child: Container(
          decoration: BoxDecoration(
            color: Colors.teal.shade700,
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