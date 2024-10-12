import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questionário',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CriarQuestionario(),
    );
  }
}

class CriarQuestionario extends StatefulWidget {
  @override
  _CriarQuestionarioState createState() => _CriarQuestionarioState();
}

class _CriarQuestionarioState extends State<CriarQuestionario> {
  int _perguntaAtual = 0;
  List<String> perguntas = [
    'Qual sua cor favorita?',
    'Qual seu animal favorito?',
    'Qual seu hobby favorito?'
  ];

  List<String> respostas = ['', '', ''];

  void _proximaPergunta() {
    if (_perguntaAtual < perguntas.length - 1) {
      setState(() {
        _perguntaAtual++;
      });
    } else {
      // Quando terminar, exibir uma mensagem ou processar as respostas
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Questionário Completo'),
          content: Text('Suas respostas foram salvas.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              perguntas[_perguntaAtual],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                respostas[_perguntaAtual] = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite sua resposta',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _proximaPergunta,
              child: Text(_perguntaAtual < perguntas.length - 1
                  ? 'Próxima'
                  : 'Finalizar'),
            ),
          ],
        ),
      ),
    );
  }
}
