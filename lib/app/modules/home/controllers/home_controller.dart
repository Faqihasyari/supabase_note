import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_note/app/data/models/note_model.dart';
import 'package:supabase_note/app/routes/app_pages.dart';

class HomeController extends GetxController {
  RxList allNotes = List<Note>.empty().obs;
  SupabaseClient client = Supabase.instance.client;
  Future<void> getAllNotes() async {
    var user = await client
        .from("users")
        .select("id")
        .match({"uid": client.auth.currentUser!.id}).single();

    var notes =
        await client.from("notes").select().match({"user_id": user["id"]});
    allNotes.value = Note.fromJsonList(notes) ?? [];

    print(allNotes);
    allNotes.refresh;
    print(notes);
  }

  void deleteNote(int id) async {
    await client.from("notes").delete().match({"id": id});
    getAllNotes();
  }
}
