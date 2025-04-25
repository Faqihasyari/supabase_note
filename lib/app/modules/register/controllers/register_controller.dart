import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_note/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  void signup() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        AuthResponse res =
            await client.auth.signUp(email: emailC.text, password: passC.text);
        Get.snackbar("Berhasil", "Akun Berhasil Dibuat");
        Get.offAllNamed(Routes.HOME);
      } on AuthException catch (e) {
        Get.snackbar("Gagal", e.message);
        Get.back();
      } catch (e) {
        Get.snackbar("Error", e.toString());
      } finally {
        isLoading.value = false;
      }
      // Get.defaultDialog(
      //   barrierDismissible: false,
      //     title: "BERHASIL REGISTER",
      //     middleText: "Periksa dan lakukan email konfirmasi",
      //     actions: [
      //       OutlinedButton(
      //           onPressed: () {
      //             Get.back(); //Buat tutup dialog
      //             Get.back(); //Kembali ke login
      //           }, child: Text("Oke Saya Mengerti"))
      //     ]);
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan password belum diisi");
    }
  }
}
