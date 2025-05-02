import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_note/app/modules/home/controllers/home_controller.dart';

class AddNoteController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  void addNote() async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      isLoading.value = true;
      var user = await client
          .from("users")
          .select("id")
          .match({"uid": client.auth.currentUser!.id}).single();

      await client.from("notes").insert({
        "user_id": user['id'],
        "title": titleC.text,
        "desc": descC.text,
        "created_at": DateTime.now().toIso8601String(),
      });

      // Trigger refresh data di HomeController
      Get.find<HomeController>().getAllNotes();

      isLoading.value = false;
      Get.back(); // opsional: kembali ke halaman sebelumnya
    }
  }
}
