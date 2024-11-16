import 'package:engenharia_projeto/app/controller/loginView.controller.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(()=> LoginController());
  }
}