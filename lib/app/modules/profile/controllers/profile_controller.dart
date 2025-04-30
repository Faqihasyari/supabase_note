import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  RxString lastLogin = "-".obs;
  TextEditingController nameC = TextEditingController(text: "Faqih");
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<void> getProfile() async {
    List<Map<String, dynamic>> res = await client.from("users").select().match({
      "uid": client.auth.currentUser!.id,
    });

    if (res.isNotEmpty) {
      var user = res.first;
      nameC.text = user["name"];
      emailC.text = user["email"];
    } else {
      print("User not found");
    }
    lastLogin.value = DateFormat.yMMMEd()
        .add_jms()
        .format(DateTime.parse(client.auth.currentUser!.lastSignInAt!));

    print(res);
  }

  Future<void> logout() async {
    await client.auth.signOut();
  }

  Future<void> updateProfile() async {
    if (nameC.text.isNotEmpty) {
      if (passC.text.isNotEmpty && passC.text.length <= 6) {
        Get.snackbar("Terjadi Kesalahan", "Password Harus lebih dari 6");
        return;
      }
      isLoading.value = true;

      if (passC.text.isNotEmpty) {
        if (passC.text.length > 6) {
          try {
            await client.auth.updateUser(UserAttributes(
              password: passC.text,
            ));
          } catch (e) {
            Get.snackbar("Terjadi Kesalahan", "$e");
          }
        } else {
          Get.snackbar(
              "Terjadi Kesalahan", "Password harus lebih dari 6 karakter");
        }

        //dia sekalian update passworsd
      }
      await client.from("users").update({"name": nameC.text}).match({
        "uid": client.auth.currentUser!.id,
      });
      isLoading.value = false;
      Get.back();
    }
  }
}
