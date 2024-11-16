import 'package:engenharia_projeto/app/models/BancoDeQuestao.model.dart';

class Questao {
  final String id;
  final List<BancoDeQuestao> bancoQuestao;
  final String pergunta;
  final String resposta;

  Questao({
    required this.id,
    required this.bancoQuestao,
    required this.pergunta,
    required this.resposta, 
  });

  factory Questao.fromJson(Map<String, dynamic> json) => Questao(
        id: json['id'] as String,
        bancoQuestao: (json['bancoQuestao'] as List)
            .map((bancoJson) => BancoDeQuestao.fromJson(bancoJson))
            .toList(),
        pergunta: json['pergunta'],
        resposta: json['resposta'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'bancoQuestao': bancoQuestao.map((banco) => banco.toJson()).toList(),
        'pergunta': pergunta,
        'resposta': resposta,
      };
}
