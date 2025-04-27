import 'package:flutter/material.dart';
import 'package:samwise/app/controllers/home_controller.dart';
import 'package:samwise/app/data/database_service.dart';
import 'package:samwise/app/views/home_view.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.database;
  sqfliteFfiInit();

  Get.put(HomeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: ' Samwise - App de fidelidade do cliente',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeView(),
    );
  }
}
