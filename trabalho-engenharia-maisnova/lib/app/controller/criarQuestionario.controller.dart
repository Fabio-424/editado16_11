import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:engenharia_projeto/app/models/Questionario.model.dart';
import 'package:engenharia_projeto/app/models/user.model.dart';

class CriarQuestionarioController extends GetxController {
  // Controladores de texto e variáveis
  final TextEditingController entrevistadorController = TextEditingController();
  final TextEditingController linkQuestionarioController = TextEditingController();
  final TextEditingController modoAplicacaoController = TextEditingController();
  final TextEditingController prazoAplicacaoController = TextEditingController();
  final TextEditingController prazoExpiracaoController = TextEditingController();
  final TextEditingController statusAtividadeController = TextEditingController();
  final TextEditingController temaController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController entrevistadorSelecionado = TextEditingController();
  
  final RxList<Usuario> usuariosFiltrados = <Usuario>[].obs;
  bool statusPublicacao = false;
  var exibirSugestoes = true.obs;
  final FocusNode entrevistadorFocusNode = FocusNode();
  
  //-------------CREATE
  Future<void> createQuestionario() async {
  try {
    // Verifica se o entrevistador existe pelo email
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Usuario')
        .where('email', isEqualTo: entrevistadorController.text) // Usa o email para buscar
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      Get.snackbar('Erro', 'Entrevistador não encontrado. Selecione um entrevistador válido.');
      return;
    }

    // Pega o primeiro documento encontrado
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = querySnapshot.docs.first;

    // Cria uma referência ao novo documento na coleção `Questionario`
    final docRef = FirebaseFirestore.instance.collection('Questionario').doc();

    Questionario questionario = Questionario(
        id: docRef.id,
        linkQuestionario: linkQuestionarioController.text,
        entrevistador: entrevistadorController.text, // Usando apenas uma string
        modoAplicacao: modoAplicacaoController.text,
        prazoAplicacao: prazoAplicacaoController.text,
        prazoExpiracao: prazoExpiracaoController.text,
        statusAtividade: statusAtividadeController.text,
        statusPublicacao: statusPublicacao,
        tema: temaController.text,
        titulo: tituloController.text,
      );

      await docRef.set(questionario.toJson());

      Get.snackbar('Sucesso', 'Questionário salvo com sucesso!');
      
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao salvar questionário: $e');
    }
}


  //-------------READ
  Stream<List<Questionario>> readQuestionarios() {
    return FirebaseFirestore.instance
      .collection('Questionario')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          // Certifique-se de que a conversão está correta
          return Questionario(
            id: doc.id,
              linkQuestionario: doc['linkQuestionario'] ?? '',
              entrevistador: doc['entrevistador'] ?? '',
              modoAplicacao: doc['modoAplicacao'] ?? '',
              prazoAplicacao: doc['prazoAplicacao'] ?? '',
              prazoExpiracao: doc['prazoExpiracao'] ?? '',
              statusAtividade: doc['statusAtividade'] ?? '',
              statusPublicacao: doc['statusPublicacao'] ?? false, // Supondo que seja um booleano
              tema: doc['tema'] ?? '',
              titulo: doc['titulo'] ?? '',
          );
        }).toList();
      });
  }

  // Função para atualizar um questionário existente
  Future<void> updateQuestionario(String id) async {
    try {
      Questionario questionarioAtualizado = Questionario(
        id: id,
        titulo: tituloController.text,
        entrevistador: entrevistadorSelecionado.text,
        linkQuestionario: linkQuestionarioController.text,
        modoAplicacao: modoAplicacaoController.text,
        prazoAplicacao: prazoAplicacaoController.text,
        prazoExpiracao: prazoExpiracaoController.text,
        statusAtividade: statusAtividadeController.text,
        statusPublicacao: statusPublicacao,
        tema: temaController.text,
      );

      await FirebaseFirestore.instance
          .collection('Questionario')
          .doc(id)
          .update(questionarioAtualizado.toJson());

      Get.snackbar('Sucesso', 'Questionário atualizado com sucesso!');
      clearFields();
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao atualizar questionário: $e');
    }
  }

 //-------------DELETE
  Future<void> deleteQuestionario(String idUser) async {
    final docUser = FirebaseFirestore.instance.collection('Questionario').doc(idUser);

    try {
      await docUser.delete();
      Get.snackbar('Sucesso', 'Questionário deletado com sucesso!');
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao deletar questionário: $e');
    }
  }

  // FUNÇOES AUXILIARES

  // Função para buscar usuários conforme o nome
  Future<void> buscarNomeUsuarios(String nome) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .where('nome', isGreaterThanOrEqualTo: nome)
          .where('nome', isLessThan: nome + '\uf8ff')
          .get();

      List<Usuario> usuariosEncontrados = querySnapshot.docs
          .map((doc) => Usuario.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      usuariosFiltrados.value = usuariosEncontrados;
    } catch (e) {
      print('Erro ao buscar usuários: $e');
    }
  }

  // Função para adicionar e remover entrevistador
  
  
  // Função para limpar os campos após salvar ou atualizar
  void clearFields() {
    entrevistadorController.clear();
    linkQuestionarioController.clear();
    modoAplicacaoController.clear();
    prazoAplicacaoController.clear();
    prazoExpiracaoController.clear();
    statusAtividadeController.clear();
    statusPublicacao = false;
    temaController.clear();
    tituloController.clear();
  }

  @override
  void onClose() {
    entrevistadorController.dispose();
    linkQuestionarioController.dispose();
    modoAplicacaoController.dispose();
    prazoAplicacaoController.dispose();
    prazoExpiracaoController.dispose();
    statusAtividadeController.dispose();
    temaController.dispose();
    tituloController.dispose();
    super.onClose();
  }

  void buscarUsuariosPorEmail(String email) async {
    if (email.isEmpty) {
      usuariosFiltrados.clear();
      return;
    }
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Usuario')
        .where('email', isGreaterThanOrEqualTo: email)
        .where('email', isLessThanOrEqualTo: '$email\uf8ff')
        .get();
    usuariosFiltrados.value = querySnapshot.docs
        .map((doc) => Usuario.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
