import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_note/app/data/models/note_model.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  Note note = Get.arguments;
  EditNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.titleC.text = note.title!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT NOTE'),
        centerTitle: true,
      ),
      body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.titleC,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.descC,
              decoration: InputDecoration(
                labelText: "Descriprion",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      //eksekusi addNote
                      bool res = await controller.addNote();
                      if (res == true) {
                        await homeC.getAllNotes();
                        Get.back();
                      }
                    }
                  },
                  child: Text(controller.isLoading.isFalse
                      ? "ADD NOTE"
                      : "LOADING.....")),
            )
          ],
        )
    );
  }
}
