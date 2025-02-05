
class ShopData {
  final String shopName;
  final String deliverDate;
  final String pcs;
  final String receivedDate;
  final String rate;
  final double total;
  final String bagHandle;
  final bool isCompleted;
  final String other;
  final String size;
  final String tailorName;

  ShopData({
    required this.shopName,
    required this.deliverDate,
    required this.pcs,
    required this.receivedDate,
    required this.rate,
    required this.total,
    required this.bagHandle,
    required this.isCompleted,
    required this.other,
    required this.size,
    required this.tailorName,
  });

  factory ShopData.fromDocument(Map<String, dynamic> data) {
    return ShopData(
      shopName: data['shopName'] ?? '',
      deliverDate: data['date'] ?? '',
      pcs: data['pcs'] ?? '',
      receivedDate: data['receivedDate'] ?? '',
      rate: data['rate'] ?? '',
      total: (data['totalAmount'] ?? 0).toDouble(),
      bagHandle: data['Handle'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      other: data['other'] ?? '',
      size: data['size'] ?? '',
      tailorName: data['tailorName'] ?? '',
    );
  }
}