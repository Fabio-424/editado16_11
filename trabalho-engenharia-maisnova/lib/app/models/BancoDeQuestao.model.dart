import 'package:engenharia_projeto/app/models/Questao.model.dart';

class BancoDeQuestao {
  final String id;
  final String titulo;
  final List<Questao> questao;
  

  BancoDeQuestao({
    required this.id,
    required this.titulo,
    required this.questao,
    
  });

  factory BancoDeQuestao.fromJson(Map<String, dynamic> json) => BancoDeQuestao(
        id: json['id'] as String,
        titulo: json['titulo'] as String,
        questao: (json['questao'] as List)
            .map((questaoJson) => Questao.fromJson(questaoJson))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'questao': questao.map((questao) => questao.toJson()).toList(),
        
      };
}
