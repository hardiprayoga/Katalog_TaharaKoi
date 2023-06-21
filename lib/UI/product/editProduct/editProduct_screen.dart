import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Service/dbservice.dart';

class EditProductMenuPage extends StatefulWidget {
  @override
  _EditProductMenuPageState createState() => _EditProductMenuPageState();
}

class _EditProductMenuPageState extends State<EditProductMenuPage> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, Admin'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    color: Colors.black,
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: DbServices.menuCollection
                  .orderBy('name', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.black),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No Menu Available',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }

                List<QueryDocumentSnapshot> filteredDocs =
                    snapshot.data!.docs.where((doc) {
                  String nama = doc['name'] as String;
                  return nama.toLowerCase().contains(searchText.toLowerCase());
                }).toList();

                if (filteredDocs.isEmpty) {
                  return Center(
                    child: Text(
                      'No Menu Found',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot menuSnapshot = filteredDocs[index];
                    Map<String, dynamic>? menuData =
                        menuSnapshot.data() as Map<String, dynamic>?;

                    if (menuData == null) {
                      return SizedBox();
                    }

                    String menuId = menuSnapshot.id;
                    String nama = menuData['name'] as String;
                    String deskripsi = menuData['description'] as String;
                    String? gambar = menuData['image'] as String?;

                    return Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          child: gambar != null && gambar.isNotEmpty
                              ? Image.network(gambar, fit: BoxFit.cover)
                              : null,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'Edit Menu',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            initialValue: nama,
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                              labelStyle:
                                                  TextStyle(color: Colors.black),
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              nama = value;
                                            },
                                          ),
                                          SizedBox(height: 16.0),
                                          TextFormField(
                                            initialValue: deskripsi,
                                            decoration: InputDecoration(
                                              labelText: 'Description',
                                              labelStyle:
                                                  TextStyle(color: Colors.black),
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              deskripsi = value;
                                            },
                                          ),
                                          SizedBox(height: 16.0),
                                          TextFormField(
                                            initialValue: gambar ?? '',
                                            decoration: InputDecoration(
                                              labelText: 'Image',
                                              labelStyle:
                                                  TextStyle(color: Colors.black),
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              gambar = value;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Save the updated data
                                          DbServices.createOrUpdateMenu(
                                            menuId,
                                            nama: nama,
                                            deskripsi: deskripsi,
                                            gambar: gambar,
                                          );

                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Save',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit_document,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'Confirmation',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    content: Text(
                                      'Data akan dihapus?',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          DbServices.deleteMenu(menuId);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
