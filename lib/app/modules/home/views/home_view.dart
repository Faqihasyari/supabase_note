import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => controller.logout(), icon: Icon(Icons.logout))
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
