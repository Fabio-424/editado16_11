import 'package:engenharia_projeto/app/controller/loginView.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PasswordField extends GetView<LoginController> {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.passwordInput, 
      decoration: const InputDecoration(hintText: 'Senha'),
    );
  }
}