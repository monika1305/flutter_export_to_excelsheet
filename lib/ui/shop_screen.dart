import 'package:flutter/material.dart';
import 'package:flutter_export_to_excelsheet/controller/export_controller.dart';
import 'package:get/get.dart';

class ShopDataScreen extends StatelessWidget {
  final ExportController exportController = Get.find<ExportController>(); // Use Get.find() to access instance


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Data")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: exportController.fetchData,
            child: Text("Fetch Data"),
          ),
          Expanded(
            child: Obx(() {
              if (exportController.allData.isEmpty) {
                return const Center(child: Text("No data available"));
              }
              return ListView.builder(
                itemCount: exportController.allData.length,
                itemBuilder: (context, index) {
                  final shop = exportController.allData[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(shop.shopName),
                      subtitle: Text("Tailor: ${shop.tailorName}, Pcs: ${shop.pcs}"),
                      trailing: Text("\$${shop.total.toStringAsFixed(2)}"),
                    ),
                  );
                },
              );
            }),
          ),
          ElevatedButton(
            onPressed: exportController.exportToExcel,
            child: const Text("Export to Excel"),
          ),
        ],
      ),
    );
  }
}
