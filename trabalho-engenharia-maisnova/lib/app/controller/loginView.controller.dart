import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engenharia_projeto/app/home/home.view.dart';
import 'package:engenharia_projeto/app/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});
  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    
  }

  Future<void> logarComGoogle() async {
      try {
        // Login com Google
        GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        
        // Obter o UID do usuário
        String? uid = userCredential.user?.uid;

        // Obter informações adicionais do usuário do Google
        Map<String, dynamic> userData = {
          'UID': uid,
          'nome': googleUser?.displayName ?? '',
          'email': googleUser?.email ?? '',
          'fotoPerfilURL': googleUser?.photoUrl ?? '',
          'criadoEm':
              Timestamp.now(), 
        };

       
       

        // Salvar ou atualizar os dados do usuário no Firestore
        await FirebaseFirestore.instance.collection('Usuario').doc(uid).set(
            userData,
            SetOptions(merge: true)); // Merge para atualizar se já existir

        // Atualizar o estado local com os dados do usuário
        this.userData.value = userData;

        // Navegar para a tela inicial
        Get.offAll(() => HomeView());
      } catch (e) {
        // Tratar erros
        print('Erro ao logar com Google: $e');
        Get.snackbar('Erro', 'Falha ao autenticar com o Google');
      }
    }
}
