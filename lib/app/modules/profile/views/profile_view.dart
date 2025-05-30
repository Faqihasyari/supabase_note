import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_note/app/controllers/auth_controller.dart';
import 'package:supabase_note/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();

  ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MY PROFILE'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                await controller.logout();
                await authC.reset();
                Get.offAllNamed(Routes.LOGIN);
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body: FutureBuilder(
            future: controller.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  TextField(
                    autocorrect: false,
                    controller: controller.nameC,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Name", border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    readOnly: true,
                    autocorrect: false,
                    controller: controller.emailC,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Email", border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => TextField(
                      obscureText: controller.isHidden.value,
                      autocorrect: false,
                      controller: controller.passC,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () => controller.isHidden.toggle(),
                              icon: controller.isHidden.isTrue
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.remove_red_eye_outlined)),
                          labelText: "New Password",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Last Login :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Obx(
                    () => Text(
                      "${controller.lastLogin}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Obx(() => ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          //eksekusi register
                          // controller.signup();
                          controller.updateProfile();
                          if (controller.passC.text.isNotEmpty && controller.passC.text.length > 6) {
                            await controller.logout();
                            await authC.reset();
                            Get.offAllNamed(Routes.LOGIN);
                          }
                        }
                      },
                      child: Text(controller.isLoading.isFalse
                          ? 'UPDATE PROFILE'
                          : 'LOADING')))
                ],
              );
            }));
  }
}
