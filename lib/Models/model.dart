import 'package:flutter_application_1/Models/Product/product.dart';


class CartModel {
  dynamic menuId;
  int quantity;
  Product katalog; // Tambahkan field menu untuk menyimpan data menu terkait

  CartModel({
    required this.menuId,
    required this.quantity,
    required this.katalog,
  });
}
