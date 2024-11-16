import 'package:engenharia_projeto/app/widgets/loginButton.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:engenharia_projeto/app/controller/loginView.controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Adicionando um fundo gradiente
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f2027), Color(0xFF2c5364)], // Cores do gradiente
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 1),

                  // Texto "Login"
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Texto branco
                    ),
                  ),

                  const SizedBox(height: 100),

                  // Texto "Acesse com seu e-mail institucional"
                  const Text(
                    'Acesse com seu e-mail institucional',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70, // Texto branco com opacidade
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Botão "Continue com o Google"
                  LoginButton(),

                  const SizedBox(height: 120),

                  // Logo da UESB
                  Image.asset(
                    'lib/app/images/logouesbbranca.png', // Caminho da imagem da UESB
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}