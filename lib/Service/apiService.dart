// import 'dart:convert';


// import 'package:flutter_application_1/Models/Product/product.dart';
// import 'package:flutter_application_1/Models/User/user.dart';
// import 'package:flutter_application_1/Models/errormsg.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class APIService {
//   static final host = 'http://192.168.8.103/APIFlutter/public/';
//   static final hostStorage = 'http://192.168.8.103/APIFlutter/storage/app/';

//   static Future<SharedPreferences> getPreferences() async {
//     return await SharedPreferences.getInstance();
//   }

//   static Future<void> getPref() async {
//     SharedPreferences prefs = await getPreferences();
//     _token = prefs.getString('token') ?? "";
//     _id = prefs.getInt('id_user');
//   }

//   static var _token = "";
//   static var _id;

//   static Future<ErrorMSG> signIn(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse(host + 'api/login'),
//         body: {
//           "email": email,
//           "password": password,
//         },
//       );
//       if (response.statusCode == 200) {
//         var res = jsonDecode(response.body);
//         SharedPreferences prefs = await getPreferences();
//         prefs.setBool('login', true);
//         prefs.setString('token', res['token']);
//         prefs.setString('name', res['user']['name']);
//         prefs.setString('email', res['user']['email']);
//         prefs.setInt('id_user', res['user']['id']);
//         return ErrorMSG.fromJson(res);
//       } else {
//         return ErrorMSG.fromJson(jsonDecode(response.body));
//       }
//     } catch (e) {
//       return ErrorMSG(success: false, message: 'error caught: $e');
//     }
//   }

//   static Future<ErrorMSG> signup(
//       String name, String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse(host + 'api/signup'),
//         body: {
//           "name": name,
//           "email": email,
//           "password": password,
//         },
//       );
//       if (response.statusCode == 200) {
//         var res = jsonDecode(response.body);
//         SharedPreferences prefs = await getPreferences();
//         prefs.setBool('login', true);
//         prefs.setString('token', res['token']);
//         prefs.setString('name', res['user']['name']);
//         prefs.setString('email', res['user']['email']);
//         prefs.setInt('id_user', res['user']['id']);
//         return ErrorMSG.fromJson(res);
//       } else {
//         return ErrorMSG.fromJson(jsonDecode(response.body));
//       }
//     } catch (e) {
//       return ErrorMSG(success: false, message: 'error caught: $e');
//     }
//   }

//   static Future<ErrorMSG> logut() async {
//     await getPref();
//     try {
//       final response = await http.get(
//         Uri.parse(host + 'api/logout'),
//         headers: {
//           'Authorization': 'Bearer ' + _token,
//         },
//       );
//       if (response.statusCode == 200) {
//         var res = jsonDecode(response.body);

//         SharedPreferences prefs = await getPreferences();
//         prefs.setBool('login', false);
//         prefs.clear();
//         _token = '';
//         return ErrorMSG.fromJson(res);
//       } else {
//         return ErrorMSG.fromJson(jsonDecode(response.body));
//       }
//     } catch (e) {
//       return ErrorMSG(success: false, message: 'error caught: $e');
//     }
//   }

//   static Future<List<Product>> getProduct(
//       int page, String search) async {
//     await getPref();
//     try {
//       final response = await http.get(
//         Uri.parse(host +
//             'api/product?page=' +
//             page.toString() +
//             '&search=' +
//             search.toString()),
//         headers: {
//           'Authorization': 'Bearer ' + _token,
//         },
//       );
//       if (response.statusCode == 200) {
//         var json = jsonDecode(response.body);
//         final parsed =
//             json['data_product']['data'].cast<Map<String, dynamic>>();
//         return parsed.map<Product>((json) => Product.fromJson(json)).toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       return [];
//     }
//   }

//   static Future<List<Product>> getProductBySeller() async {
//     await getPref();
//     try {
//       final response = await http.get(
//         Uri.parse(host + 'api/product/seller/' + _id.toString()),
//         headers: {
//           'Authorization': 'Bearer ' + _token,
//         },
//       );
//       if (response.statusCode == 200) {
//         var json = jsonDecode(response.body);
//         final parsed = json['data_product'].cast<Map<String, dynamic>>();
//         return parsed.map<Product>((json) => Product.fromJson(json)).toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       return [];
//     }
//   }

//   // static Future<List<Category>> getCategory() async {
//   //   await getPref();
//   //   try {
//   //     final response = await http.get(
//   //       Uri.parse(host + 'api/category'),
//   //       headers: {
//   //         'Authorization': 'Bearer ' + _token,
//   //       },
//   //     );
//   //     if (response.statusCode == 200) {
//   //       var json = jsonDecode(response.body);
//   //       final parsed = json['data_categories'].cast<Map<String, dynamic>>();
//   //       return parsed.map<Category>((json) => Category.fromJson(json)).toList();
//   //     } else {
//   //       return [];
//   //     }
//   //   } catch (e) {
//   //     return [];
//   //   }
//   // }

//   static Future<User> getUserId() async {
//     SharedPreferences prefs = await getPreferences();
//     var id = prefs.getInt('id_user');
//     try {
//       final response = await http.get(
//         Uri.parse(host + 'api/user/' + id.toString()),
//         headers: {
//           'Authorization': 'Bearer ' + _token,
//         },
//       );
//       if (response.statusCode == 200) {
//         var json = jsonDecode(response.body);
//         return User.fromJson(json['user']);
//       } else {
//         throw Exception('Failed to load User');
//       }
//     } catch (e) {
//       throw Exception('Failed to load User');
//     }
//   }

//   static Future<ErrorMSG> saveProduct(product, filepath) async {
//     SharedPreferences prefs = await getPreferences();
//     var id = prefs.getInt('id_user');
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(host + 'api/product'),
//       );
//       request.fields['nama'] = product['nama'];
//       request.fields['seller'] = id.toString();
//       request.fields['id_kategori'] = product['kategori'];
//       request.fields['deskripsi'] = product['deskripsi'];
//       request.fields['harga'] = product['harga'];
//       request.fields['stok'] = product['stok'];
//       if (filepath != '') {
//         request.files.add(
//           await http.MultipartFile.fromPath('gambar', filepath),
//         );
//       }
//       request.headers.addAll({
//         'Authorization': 'Bearer ' + _token,
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       });
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         final respStr = await response.stream.bytesToString();
//         return ErrorMSG.fromJson(jsonDecode(respStr));
//       } else {
//         return ErrorMSG(
//           success: false,
//           message: 'err Request',
//         );
//       }
//     } catch (e) {
//       ErrorMSG responseRequest =
//           ErrorMSG(success: false, message: 'error caught: $e');
//       return responseRequest;
//     }
//   }

//   static Future<ErrorMSG> updateProduct(product, filepath) async {
//     SharedPreferences prefs = await getPreferences();
//     var idSeller = prefs.getInt('id_user');
//     var id = product['id'];
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(host + 'api/product/' + id.toString()),
//       );
//       request.fields['nama'] = product['nama'];
//       request.fields['seller'] = idSeller.toString();
//       request.fields['id_kategori'] = product['kategori'];
//       request.fields['deskripsi'] = product['deskripsi'];
//       request.fields['harga'] = product['harga'];
//       request.fields['stok'] = product['stok'];
//       if (filepath != '') {
//         request.files.add(
//           await http.MultipartFile.fromPath('gambar', filepath),
//         );
//       }
//       request.headers.addAll({
//         'Authorization': 'Bearer ' + _token,
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       });
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         final respStr = await response.stream.bytesToString();
//         return ErrorMSG.fromJson(jsonDecode(respStr));
//       } else {
//         return ErrorMSG(
//           success: false,
//           message: 'err Request',
//         );
//       }
//     } catch (e) {
//       ErrorMSG responseRequest =
//           ErrorMSG(success: false, message: 'error caught: $e');
//       return responseRequest;
//     }
//   }

//   static Future<ErrorMSG> deleteProduct(id) async {
//     await getPref();
//     try {
//       var request = http.MultipartRequest(
//         'DELETE',
//         Uri.parse(host + 'api/product/' + id.toString()),
//       );
//       request.headers.addAll({
//         'Authorization': 'Bearer ' + _token,
//       });
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         final respStr = await response.stream.bytesToString();
//         return ErrorMSG.fromJson(jsonDecode(respStr));
//       } else {
//         return ErrorMSG(
//           success: false,
//           message: 'err Request',
//         );
//       }
//     } catch (e) {
//       ErrorMSG responseRequest =
//           ErrorMSG(success: false, message: 'error caught: $e');
//       return responseRequest;
//     }
//   }
// }
