import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_note/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController nameC = TextEditingController(text: "Faqih");
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  void signup() async {
    if (nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        AuthResponse res =
            await client.auth.signUp(email: emailC.text, password: passC.text);
        //insert data ke table
        if (res.user != null) {
          final response = await client.from("users").insert({
            "uid": res.user!.id,
            "email": emailC.text,
            "name": nameC.text,
            "created_at": DateTime.now().toIso8601String(),
          });
          Get.snackbar("Berhasil", "Akun Berhasil Dibuat");
          Get.offAllNamed(Routes.HOME);
        }
      } on AuthException catch (e) {
        Get.snackbar("Gagal", e.message);
        Get.back();
      } catch (e) {
        Get.snackbar("Error", e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan password belum diisi");
    }
  }
}
