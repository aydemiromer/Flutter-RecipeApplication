import 'package:flutter/material.dart';
import 'package:flutter_firebase_get/screens/CategoriesPage.dart';
import 'package:firebase_database/firebase_database.dart';

class CategoriesFull extends StatelessWidget {
  final DatabaseReference refKategoriler;

  const CategoriesFull({Key key, this.refKategoriler}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Color(0xFFFFCC80),
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.orange,
          title: Center(
            child: Text(
              'Lütfen Seçim Yapınız',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: CategoriesPage(refKategoriler: refKategoriler),
      ),
    );
  }
}
