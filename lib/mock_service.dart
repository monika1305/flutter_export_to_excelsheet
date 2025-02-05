import 'package:flutter_export_to_excelsheet/shop_data.dart';

class MockShopDataService {
  List<ShopData> fetchMockShopData() {
    return [
      ShopData(
        shopName: "Fashion Tailors",
        deliverDate: "2025-02-10",
        pcs: "10",
        receivedDate: "2025-02-05",
        rate: "15",
        total: 150.0,
        bagHandle: "Plastic",
        isCompleted: false,
        other: "Urgent",
        size: "M",
        tailorName: "John Doe",
      ),
      ShopData(
        shopName: "Elegant Stitch",
        deliverDate: "2025-02-12",
        pcs: "5",
        receivedDate: "2025-02-07",
        rate: "20",
        total: 100.0,
        bagHandle: "Paper",
        isCompleted: true,
        other: "Regular",
        size: "L",
        tailorName: "Jane Smith",
      ),
    ];
  }
}