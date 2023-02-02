import 'package:flutter/material.dart';

import '../data/dbHelper.dart';
import '../models/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State {

  var dbHelper= DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Name"),
      controller: txtName,
    );
  }

  Widget buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Description"),
      controller: txtDescription,
    );
  }

  Widget buildUnitPriceField() {
    return TextField(
       decoration: InputDecoration(labelText: "Product Unit Price"),
       controller: txtUnitPrice,
     );
  }

  
  buildSaveButton() {
    return ElevatedButton(
        onPressed: (){
          addProduct();
        },
        child: Text("Add")
    );
  }

  void addProduct() async {
    var result=await dbHelper.insert(Product(txtName.text,txtDescription.text,double.tryParse(txtUnitPrice.text)));
    Navigator.pop(context,true);
  }
}