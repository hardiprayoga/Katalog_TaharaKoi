import 'package:flutter/material.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
final String menuId = "menuId";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailMenu(),
    );
  }
}