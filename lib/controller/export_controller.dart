
import 'package:excel/excel.dart';
import 'package:flutter_export_to_excelsheet/mock_service.dart';
import 'package:flutter_export_to_excelsheet/shop_data.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;

class ExportController extends GetxController {
  var allData = <ShopData>[].obs;
  final MockShopDataService mockShopDataService = MockShopDataService();

  void fetchData() {
    allData.value = mockShopDataService.fetchMockShopData();
  }

  Future<void> exportToExcel() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    // Add Developer/additional Information at the top left
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value = TextCellValue("Developer Name: Monika Sharma");
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1)).value = TextCellValue("Address: 123 Main Street, City, Country");

    List<String> headers = [
      'Date', 'Shop Name', 'Tailor Name', 'Size', 'H', 'Other', 'Pcs', 'Rate', 'Total'
    ];
    for (int i = 0; i < headers.length; i++) {
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 3)).value = TextCellValue(headers[i]);
    }

    for (int i = 0; i < allData.length; i++) {
      ShopData item = allData[i];
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 4)).value = TextCellValue(item.deliverDate);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 4)).value = TextCellValue(item.shopName);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 4)).value = TextCellValue(item.tailorName);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 4)).value = TextCellValue(item.size);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 4)).value = TextCellValue(item.bagHandle);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 4)).value = TextCellValue(item.other);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 4)).value = TextCellValue(item.pcs);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 4)).value = TextCellValue(item.rate);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 4)).value = DoubleCellValue(item.total);
    }

    List<int>? fileBytes = excel.save();
    if (fileBytes == null) {
      Get.snackbar("Error", "Failed to generate Excel file");
      return;
    }

    if (kIsWeb) {
      // Handle file download in Web
      final blob = html.Blob([fileBytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "shop_data_export.xlsx")
        ..click();
      html.Url.revokeObjectUrl(url);
      Get.snackbar("Success", "Excel file downloaded");
        } else {
      // Handle Mobile File Storage
      var status = await Permission.storage.request();
      if (status.isGranted) {
        String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
        String filePath = '/storage/emulated/0/Download/shop_data_export_$formattedDate.xlsx';

        File file = File(filePath);
        await file.create(recursive: true);
        await file.writeAsBytes(fileBytes);

        print('File saved at $filePath');
        Get.snackbar("Success", "Excel file saved to: $filePath");
      } else {
        Get.snackbar("Error", "Storage permission denied");
      }
    }
  }
}
