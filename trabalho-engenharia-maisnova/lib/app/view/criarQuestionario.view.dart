import 'package:engenharia_projeto/app/models/user.model.dart';
import 'package:engenharia_projeto/app/view/gerenciarQuestionario.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:engenharia_projeto/app/controller/criarQuestionario.controller.dart';

class CriarQuestionario extends StatelessWidget {
  final CriarQuestionarioController _controller = Get.put(CriarQuestionarioController());
  
  Widget _buildStatusPublicacaoDropdown(CriarQuestionarioController controller) {
    return DropdownButtonFormField<bool>(
      value: controller.statusPublicacao,
      onChanged: (bool? newValue) {
        if (newValue != null) {
          controller.statusPublicacao = newValue;
        }
      },
      decoration: InputDecoration(
        labelText: 'Status de Publicação',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: [
        DropdownMenuItem(
          value: true,
          child: Text('Publicado'),
        ),
        DropdownMenuItem(
          value: false,
          child: Text('Não Publicado'),
        ),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar questionários'),
        backgroundColor: Color(0xFF2c5364),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Nome do Questionário'),
              _buildTextField(_controller.tituloController, 'Nome do Questionário'),
              const SizedBox(height: 8),

              // Campo de busca para entrevistador
              TextField(
                controller: _controller.entrevistadorController,
                focusNode: _controller.entrevistadorFocusNode,
                decoration: InputDecoration(
                  labelText: 'Entrevistador (digite o e-mail)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                onChanged: (value) {
                  _controller.buscarUsuariosPorEmail(value);
                  _controller.exibirSugestoes.value = value.isNotEmpty;
                },
              ),

              // Listagem de sugestões de entrevistadores com filtragem
              Obx(() {
                // Condição para exibir ou esconder o ListView.builder
                if (!_controller.exibirSugestoes.value || _controller.usuariosFiltrados.isEmpty) {
                  return SizedBox.shrink(); // Retorna um widget vazio para "fechar" a lista
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: _controller.usuariosFiltrados.length,
                  itemBuilder: (context, index) {
                    final usuario = _controller.usuariosFiltrados[index];
                    return ListTile(
                      title: Text(usuario.email ?? 'No Email'),
                      onTap: () {
                        if (usuario.email != null) {
                          // Preenche o TextField com o e-mail selecionado
                          _controller.entrevistadorController.text = usuario.email!;

                          // Remove o email selecionado da lista de sugestões e "fecha" a lista
                          _controller.usuariosFiltrados.removeAt(index);
                          _controller.exibirSugestoes.value = false;
                        }
                      },
                    );
                  },
                );
              }),



              const SizedBox(height: 16),
              _buildTextField(_controller.linkQuestionarioController, 'Link do Questionário'),
              const SizedBox(height: 8),
              _buildTextField(_controller.modoAplicacaoController, 'Modo de Aplicação'),
              const SizedBox(height: 8),
              _buildTextField(_controller.prazoAplicacaoController, 'Prazo de Aplicação'),
              const SizedBox(height: 8),
              _buildTextField(_controller.prazoExpiracaoController, 'Prazo de Expiração'),
              const SizedBox(height: 8),
              _buildTextField(_controller.statusAtividadeController, 'Status da Atividade'),
              const SizedBox(height: 8),
              _buildStatusPublicacaoDropdown(_controller),
              const SizedBox(height: 8),
              _buildTextField(_controller.temaController, 'Tema'),

              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _controller.createQuestionario();
                    _controller.clearFields();
                    Get.to(GerenciarQuestionarios());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2c5364),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Salvar Questionário',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
