class Questionario {
  final String id;
  final String linkQuestionario;
  final String entrevistador; // Agora é uma string, não uma lista
  final String modoAplicacao;
  final String prazoAplicacao;
  final String prazoExpiracao;
  final String statusAtividade;
  final bool statusPublicacao;
  final String tema;
  final String titulo;

  Questionario({
    required this.id,
    required this.linkQuestionario,
    required this.entrevistador,
    required this.modoAplicacao,
    required this.prazoAplicacao,
    required this.prazoExpiracao,
    required this.statusAtividade,
    required this.statusPublicacao,
    required this.tema,
    required this.titulo,
  });

  factory Questionario.fromJson(Map<String, dynamic> json, String id) {
    return Questionario(
      id: id,
      linkQuestionario: json['linkQuestionario'] ?? '',
      entrevistador: json['entrevistador'] ?? '', // Carrega como string
      modoAplicacao: json['modoAplicacao'] ?? '',
      prazoAplicacao: json['prazoAplicacao'] ?? '',
      prazoExpiracao: json['prazoExpiracao'] ?? '',
      statusAtividade: json['statusAtividade'] ?? '',
      statusPublicacao: json['statusPublicacao'] ?? false,
      tema: json['tema'] ?? '',
      titulo: json['titulo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'linkQuestionario': linkQuestionario,
      'entrevistador': entrevistador, // Salva como string
      'modoAplicacao': modoAplicacao,
      'prazoAplicacao': prazoAplicacao,
      'prazoExpiracao': prazoExpiracao,
      'statusAtividade': statusAtividade,
      'statusPublicacao': statusPublicacao,
      'tema': tema,
      'titulo': titulo,
    };
  }
}
