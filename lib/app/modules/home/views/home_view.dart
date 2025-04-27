import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_note/app/controllers/auth_controller.dart';
import 'package:supabase_note/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => Get.toNamed(Routes.PROFILE), icon: Icon(Icons.person))
    //       IconButton(
    //         onPressed: () async {
    //           await controller.logout();
    //           await authC.reset();
    // Get.offAllNamed(Routes.LOGIN);

    //         },
    //         icon: Icon(Icons.logout),
    //       )
        ],
      ),
      body: const Center(
        child: Text(
          'HOMEVIEW',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
