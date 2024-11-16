import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engenharia_projeto/app/view/editar_banco_de_questoes.dart';

class VisualizarBancosDeQuestoes extends StatelessWidget {
  const VisualizarBancosDeQuestoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar Bancos de Questões'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bancosDeQuestoes')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os dados'));
          }

          final bancos = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: bancos.length,
            itemBuilder: (context, index) {
              final banco = bancos[index];
              final bancoId = banco.id;
              final nomeBanco = banco['nomeBanco'];

              final perguntas = List<String>.from(banco['perguntas'] ?? []);

              return ListTile(
                title: Text(nomeBanco),
                subtitle: Text('Número de perguntas: ${perguntas.length}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarBancoDeQuestoes(
                              bancoId: bancoId,
                              nomeBanco: nomeBanco,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('bancosDeQuestoes')
                            .doc(bancoId)
                            .delete();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Banco de questões excluído')),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
