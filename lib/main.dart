
import 'package:flutter/material.dart';
import 'package:flutter_export_to_excelsheet/controller/export_controller.dart';
import 'package:flutter_export_to_excelsheet/ui/shop_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void main() {
  Get.put(ExportController()); // Ensure controller is initialized before app runs

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ShopDataScreen(),
    );
  }
}
