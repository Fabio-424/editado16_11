import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engenharia_projeto/app/models/BancoDeQuestao.model.dart';
import 'package:engenharia_projeto/app/models/Questao.model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class QuestaoController extends GetxController {
  final TextEditingController perguntaController = TextEditingController();
  final TextEditingController bancoQuestaoController = TextEditingController();
  final TextEditingController respostaController = TextEditingController();

// ************* CREATE
Future<void> createQuestao() async {
  try {
    // Cria uma referência ao novo documento na coleção `Questao`
    final docRef = FirebaseFirestore.instance.collection('Questao').doc();

    List<BancoDeQuestao> listaBancosQuestoes = parseBancoQuestoes(bancoQuestaoController.text);


  if (!validarCampos()) {
    Get.snackbar('Erro', 'Todos os campos são obrigatórios.');
    return;
  }
    Questao questao = Questao(
      id: docRef.id,
      pergunta: perguntaController.text,
      resposta: respostaController.text, // Adapte de acordo com o seu modelo de resposta
      bancoQuestao: listaBancosQuestoes, // Converta para o formato correto
      
    );

    await docRef.set(questao.toJson());

    Get.snackbar('Sucesso', 'Questão salva com sucesso!');
    clearFields();
  } catch (e) {
    Get.snackbar('Erro', 'Falha ao salvar questão: $e');
  }
}

// ************* UPDATE
Future<void> updateQuestionario(String id) async {
    try {
      List<BancoDeQuestao> listaBancosQuestoes = parseBancoQuestoes(bancoQuestaoController.text);
      Questao questionarioAtualizado = Questao(
        id: id,
        pergunta: perguntaController.text,
        resposta: respostaController.text,
        bancoQuestao: listaBancosQuestoes,
      );

      await FirebaseFirestore.instance
          .collection('Questao')
          .doc(id)
          .update(questionarioAtualizado.toJson());

      Get.snackbar('Sucesso', 'Questao atualizado com sucesso!');
      clearFields();
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao atualizar questao: $e');
    }
  }
  // ************* READ
  Stream<List<Questao>> readQuestao() {
    return FirebaseFirestore.instance.collection('Questao').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) =>
                Questao.fromJson(doc.data()))
            .toList());
  }
  // ************* DELETA POR ID
  Future<void> deleteQuestaoById(String idUser) async {
    final docUser = FirebaseFirestore.instance.collection('Questao').doc(idUser);

    try {
      await docUser.delete();
      Get.snackbar('Sucesso', 'Questao deletado com sucesso!');
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao deletar Questao: $e');
    }
  }

  // ************* FUNÇÕES AUXILIARES

  // ************* FORMATA O TEXTO PARA JSON
  List<BancoDeQuestao> parseBancoQuestoes(String texto) {
  try {
    final List<dynamic> listaJson = jsonDecode(texto); // Converte o texto em lista JSON

    // Mapeia cada elemento da lista para um objeto BancoDeQuestao
    return listaJson.map((bancoJson) {
      return BancoDeQuestao.fromJson(bancoJson as Map<String, dynamic>);
    }).toList();
  } catch (e) {
    print('Erro ao converter banco de questões: $e');
    return [];
  }
}

// ************* LIMPA CAMPOS
  void clearFields() {
    perguntaController.clear();
    bancoQuestaoController.clear();
    respostaController.clear();
  }

// ************* CHECA SE NAO ESTA VAZIO
   bool validarCampos() {
    if (perguntaController.text.isEmpty ||
        bancoQuestaoController.text.isEmpty ||
        respostaController.text.isEmpty) {
      Get.snackbar('Erro', 'Todos os campos são obrigatórios.');
      return false;
    }
    return true;
  }
}
