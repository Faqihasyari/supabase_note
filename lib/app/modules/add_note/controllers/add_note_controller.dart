import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

      print(user);
      await client.from("notes").insert({
        "user_id": user['id'],
        "title": titleC.text,
        "desc": descC.text,
        "created_at": DateTime.now().toIso8601String(),
      });
      isLoading.value = false;
    }
  }
}
