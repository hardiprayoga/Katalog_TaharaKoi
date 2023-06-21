// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_application_1/Models/Product/product.dart';
// import 'package:flutter_application_1/UI/product/detailProduct/components/body.dart';


// class DetailProduct extends StatefulWidget {
//   const DetailProduct({Key? key});

//   @override
//   State<DetailProduct> createState() => _DetailProductState();
// }

// class _DetailProductState extends State<DetailProduct> {
//   final DbServices dbServices = DbServices();

//   void navigateToDetailProduct(Product menu) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MenuDetailScreen(
//           menuId: menu.id,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white10,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             FutureBuilder<List<Product>>(
//               future: dbServices.getMenuData(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           Product menu = snapshot.data![index];
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Card(
//                               child: InkWell(
//                                 onTap: () => navigateToDetailProduct(menu),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     AspectRatio(
//                                       aspectRatio:
//                                           1.0, // Menyamakan lebar dan tinggi
//                                       child: GestureDetector(
//                                         onTap: () => navigateToDetailProduct(menu),
//                                         child: Image.network(
//                                           menu.gambar,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Card(
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 16.0,
//                                           vertical: 8.0,
//                                         ),
//                                         child: Text(
//                                           menu.nama,
//                                           textAlign: TextAlign.center,
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 16.0,
//                                         vertical: 8.0,
//                                       ),
//                                       child: GestureDetector(
//                                         onTap: () => navigateToDetailProduct(menu),
//                                         child: Text(
//                                           menu.deskripsi,
//                                           textAlign: TextAlign.justify,
//                                           style: const TextStyle(fontSize: 16),
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       width: double.infinity,
//                                       color: Colors.black.withOpacity(0.3),
//                                       child: GestureDetector(
//                                         onTap: () => navigateToDetailProduct(menu),
//                                         child: const Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16.0, vertical: 8),
//                                           child: Text(
//                                             'Detail Lebih lanjut',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontStyle: FontStyle.italic,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   } else {
//                     return const Center(
//                       child: Text("Tidak ada data"),
//                     );
//                   }
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DbServices {
//   static CollectionReference menuCollection =
//       FirebaseFirestore.instance.collection('menu');

//   Future<List<Product>> getMenuData() async {
//     QuerySnapshot snapshot = await menuCollection.get();
//     List<Product> menuList = [];

//     snapshot.docs.forEach((doc) {
//       Product menu = Product.fromFirestore(doc);
//       menuList.add(menu);
//     });

//     return menuList;
//   }

// }
