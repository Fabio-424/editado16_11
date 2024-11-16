import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engenharia_projeto/app/models/BancoDeQuestao.model.dart';
import 'package:engenharia_projeto/app/models/Questao.model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class BancoDeQuestoes extends GetxController {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController questaoController = TextEditingController();

  // ************* CREATE
  Future<void> createBancoQuestao(String questionarioId) async {
  try {
    
    final docRef = FirebaseFirestore.instance.collection('BancoQuestao').doc();

    List<Questao> listasQuestao = parseQuestao(questaoController.text);

  if (!validarCampos()) {
    Get.snackbar('Erro', 'Todos os campos são obrigatórios.');
    return;
  }
    BancoDeQuestao questao = BancoDeQuestao(
      id: docRef.id,
      titulo: tituloController.text,
      questao: listasQuestao, // Converta para o formato correto
      
    );

    await docRef.set(questao.toJson());

    Get.snackbar('Sucesso', 'Banco de Questao salvo com sucesso!');
    clearFields();
  } catch (e) {
    Get.snackbar('Erro', 'Falha ao salvar questão: $e');
  }
}

 // ************* UPDATE 
Future<void> updateBancoQuestao(String id) async {
    try {
      List<Questao> listaQuestao = parseQuestao(questaoController.text);
      BancoDeQuestao bancoquestaoAtualizado = BancoDeQuestao(
        id: id,
        titulo: tituloController.text,
      questao: listaQuestao,
      );

      await FirebaseFirestore.instance
          .collection('BancoQuestao')
          .doc(id)
          .update(bancoquestaoAtualizado.toJson());

      Get.snackbar('Sucesso', 'Banco de Questao atualizado com sucesso!');
      clearFields();
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao atualizar Banco de questao: $e');
    }
  }
// ************* READ
Stream<List<BancoDeQuestao>> readBancoQuestao() {
    return FirebaseFirestore.instance.collection('BancoQuestao').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) =>
                BancoDeQuestao.fromJson(doc.data()))
            .toList());
  }



// ************* DELETE
  Future<void> deleteQuestaoById(String idUser) async {
    final docUser = FirebaseFirestore.instance.collection('Banco de Questao').doc(idUser);

    try {
      await docUser.delete();
      Get.snackbar('Sucesso', 'Banco de Questao deletado com sucesso!');
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao deletar Banco de Questao: $e');
    }
  }


  //************** DELETA UMA QUESTAO DO BANCO DE QUESTOES
  Future<void> deleteQuestaoFromBanco(String bancoId, String questaoId) async {
  final bancoRef = FirebaseFirestore.instance.collection('Banco de Questao').doc(bancoId);

  try {
    // Obter o documento do banco
    DocumentSnapshot bancoSnapshot = await bancoRef.get();

    // Converter o documento para um Map
    Map<String, dynamic> bancoData = bancoSnapshot.data() as Map<String, dynamic>;

    // Obter a lista de questões
    List<dynamic> questoes = bancoData['questao'];

    // Filtrar a lista, removendo a questão com o ID especificado
    questoes.removeWhere((questao) => questao['id'] == questaoId);

    // Atualizar o documento do banco com a nova lista de questões
    await bancoRef.update({'questao': questoes});

    Get.snackbar('Sucesso', 'Questão removida com sucesso!');
  } catch (e) {
    Get.snackbar('Erro', 'Falha ao remover a questão: $e');
  }
}

// ************* FUNÇOES AUXILIARES

//FORMATA O TEXTO PARA JSON
List<Questao> parseQuestao(String texto) {
  try {
    final List<dynamic> listaJson = jsonDecode(texto); // Converte o texto em lista JSON

    // Mapeia cada elemento da lista para um objeto BancoDeQuestao
    return listaJson.map((bancoJson) {
      return Questao.fromJson(bancoJson as Map<String, dynamic>);
    }).toList();
  } catch (e) {
    print('Erro ao converter as questões: $e');
    return [];
  }
}

// LIMPA CAMPOS
  void clearFields() {
    tituloController.clear();
    questaoController.clear();
    
  }

// CHECA SE OS CAMPOS NAO ESTAO VAZIOS
   bool validarCampos() {
    if (tituloController.text.isEmpty ||
        questaoController.text.isEmpty) {
      Get.snackbar('Erro', 'Todos os campos são obrigatórios.');
      return false;
    }
    return true;
  }
}
