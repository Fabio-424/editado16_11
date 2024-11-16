import 'package:engenharia_projeto/app/controller/loginView.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class LoginButton extends GetView<LoginController> {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.logarComGoogle();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white, // Borda branca
            width: 2, // Largura da borda
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent, // Preenchimento transparente
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'lib/app/images/Google__G__logo.png', // Caminho do ícone do Google
              height: 24, // Tamanho do ícone
            ),
            const SizedBox(width: 10),
            const Text(
              'Continue com o Google',
              style: TextStyle(
                color: Colors.white, // Texto branco
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
