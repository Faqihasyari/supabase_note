import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase supa = await Supabase.initialize(
      url: 'https://tqadbjxxrddwhtrdnvsi.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRxYWRianh4cmRkd2h0cmRudnNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU0OTcxODMsImV4cCI6MjA2MTA3MzE4M30.XfAKeb3fC-aeCZEqpXDlDYLAiL-MpOMrjpDTpGo2axo');

  supa.client.auth.signOut();
  runApp(
    GetMaterialApp(
      title: "Supanote",
      initialRoute:
          supa.client.auth.currentUser == null ? Routes.LOGIN : Routes.HOME,
      getPages: AppPages.routes,
    ),
  );
}
