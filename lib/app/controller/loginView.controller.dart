import 'package:engenharia_projeto/app/home/home.view.dart';
import 'package:engenharia_projeto/app/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  //static const String email = '2022734@uesb.edu.br';
  //static const String password = '123456';

  //CRIANDO UM BANCO DE DADOS LOCAL

  @override
  void onInit() {
    super.onInit();
  }

  void login() {
    print('Login com sucesso');
    Get.to(() => const HomeView());
  }

  void printError(String error) {
    print(error);
  }

  Future<String?> logarUsuario(
      {required String email, required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      Get.to(() => const HomeView());
      print("funfou");
      return null;
    } on FirebaseAuthException catch (e) {
      print("deu ruim");
      return e.message;
    }
  }

  void logarComGoogle() async {
    try {
      GoogleSignInAccount? usuarioGoogle = await GoogleSignIn().signIn();

      if (usuarioGoogle == null) return;

      GoogleSignInAuthentication? googleAuth = await usuarioGoogle.authentication;

      // Acessa as credenciais
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // Valida  as credenciais no FireBase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Navegar para a tela inicial após login bem-sucedido
      Get.to(() => const HomeView());

    } on FirebaseAuthException catch (e) {
      // Tratar erros de autenticação
      print("Erro no login com Google: ${e.message}");
      Get.snackbar("Erro", "Falha ao autenticar com o Google",
          snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      // Tratar outros erros
      print("Erro inesperado: $error");
      Get.snackbar("Erro", "Ocorreu um erro inesperado",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}