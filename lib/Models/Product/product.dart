import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Service/dbservice.dart';

class Product {
  late String id;
  late String nama;
  late String deskripsi;
  late String gambar;
  
  Product({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.gambar,
   
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      nama: data['name'] ?? '',
      deskripsi: data['description'] ?? '',
      gambar: data['image'] ?? '',
    );
  }
    static Future<Product?> getMenu(int menuId) async {
  DocumentSnapshot? doc = await DbServices.getMenuList(menuId.toString());
  // ignore: unnecessary_null_comparison
  if (doc == null || !doc.exists) {
    return null;
  }
  return Product.fromFirestore(doc);
}


}
