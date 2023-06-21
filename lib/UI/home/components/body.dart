import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Product/product.dart';
import 'package:flutter_application_1/Service/dbservice.dart';
import 'package:flutter_application_1/UI/product/detailProduct/components/body.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

const double kDefaultPadding = 16.0;

class DetailMenu extends StatefulWidget {
  @override
  _DetailMenuState createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  final DbServices dbServices = DbServices();
  final TextEditingController searchController = TextEditingController();
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchMenuData(pageKey);
    });
  }

  void _fetchMenuData(int pageKey) {
    dbServices.getMenuData(pageKey).then((newItems) {
      final isLastPage = newItems.length < dbServices.limit;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    }).catchError((error) {
      _pagingController.error = error;
    });
  }

  void navigateToDetailMenu(Product product, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuDetailScreen(
          menuId: product.id,
        ),
      ),
    );
  }

  void addToFavorites(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.black),
        ),
        content: Text(
          'Add to Favorites?',
          style: TextStyle(color: Colors.black),
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
              // Add logic to add product to favorites
              // Add the appropriate code here
              Navigator.pop(context);
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Text(
              'Katalog',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
            child: Text(
              'Tahara Koi',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(kDefaultPadding),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: kSecondaryLightColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: searchController,
              onChanged: (search) {
                _pagingController.refresh();
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  color: kPrimaryColor,
                ),
                hintText: "Search..",
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                ),
                PagedListView<int, Product>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Product>(
                    itemBuilder: (context, product, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.grey,
                        child: InkWell(
                          onTap: () => navigateToDetailMenu(product, context),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: GestureDetector(
                                    onTap: () => navigateToDetailMenu(product, context),
                                    child: product.gambar != ''
                                        ? Image.network(
                                            product.gambar,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      color: Colors.grey,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 8.0,
                                        ),
                                        child: Text(
                                          product.nama,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () => navigateToDetailMenu(product, context),
                                        child: Text(
                                          product.deskripsi,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () => navigateToDetailMenu(product, context),
                                            child: Text('Detail'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blue,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          ElevatedButton(
                                            onPressed: () => addToFavorites(product),
                                            child: Icon(Icons.favorite),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
