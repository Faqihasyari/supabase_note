import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC= TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  void signup()async{
    if(emailC.text.isNotEmpty && passC.text.isNotEmpty){
      isLoading.value = true;
      try {
      AuthResponse res = await client.auth.signUp(email: emailC.text ,password: passC.text);
      Get.snackbar("Berhasil", "Akun Berhasil Dibuat");
      } on AuthException catch (e){
        Get.snackbar("Gagal", e.message);
      } catch (e){
        Get.snackbar("Error", e.toString());
      } finally {
        isLoading.value = false;
      } 

      
      
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan password belum diisi");
    }
  }
}
