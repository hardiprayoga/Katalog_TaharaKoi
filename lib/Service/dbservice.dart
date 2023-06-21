import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/Product/product.dart';


class DbServices {
  static CollectionReference menuCollection =
      FirebaseFirestore.instance.collection('katalog');
final int limit = 10;

  static Future<void> createOrUpdateMenu(String id,{
  required String nama,
  required String deskripsi,
      String? gambar}) async {
    await menuCollection.doc(id).set(
      {
        'nama': nama,
        'deskripsi': deskripsi,
        'gambar': gambar,
      },
      SetOptions(merge: true),
    );
  }

  static Future<DocumentSnapshot> getMenuList(String id) async {
    return await menuCollection.doc(id).get();
  }

  static Future<void> deleteMenu(String id) async {
    await menuCollection.doc(id).delete();
  }

  static Future<Product?> getMenu(String id) async {
    DocumentSnapshot doc = await menuCollection.doc(id).get();
    if (doc.exists) {
      return Product.fromFirestore(doc);
    } else {
      return null;
    }
  }

  Future<List<Product>> getMenuData(int pageKey) async {
    QuerySnapshot snapshot = await menuCollection
        .limit(limit)
        .get();
    List<Product> menuList = [];

    snapshot.docs.forEach((doc) {
      Product product = Product.fromFirestore(doc);
      menuList.add(product);
    });

    return menuList;
  }
}
