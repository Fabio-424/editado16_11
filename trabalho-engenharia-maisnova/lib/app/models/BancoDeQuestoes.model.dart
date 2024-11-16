class BancoDeQuestoes {
  String nomeBanco;
  List<String> perguntas;
  String descricaoBanco;
  int quantidadeDeQuestoes;  

  BancoDeQuestoes({
    required this.nomeBanco,
    required this.perguntas,
    required this.descricaoBanco,
    required this.quantidadeDeQuestoes,  
  });

  Map<String, dynamic> toMap() {
    return {
      'nomeBanco': nomeBanco,
      'perguntas': perguntas,
      'descricaoBanco': descricaoBanco,
      'quantidadeDeQuestoes': quantidadeDeQuestoes,  
    };
  }

  factory BancoDeQuestoes.fromMap(Map<String, dynamic> map) {
    return BancoDeQuestoes(
      nomeBanco: map['nomeBanco'],
      perguntas: List<String>.from(map['perguntas'] ?? []),
      descricaoBanco: map['descricaoBanco'],
      quantidadeDeQuestoes: map['quantidadeDeQuestoes'],  
    );
  }
}
