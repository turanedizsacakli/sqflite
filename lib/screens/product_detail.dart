import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductDetail extends StatefulWidget {

  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }

}

enum Options{update,delete}

class _ProductDetailState extends State {

  Product product;
  _ProductDetailState(this.product);
  var dbHelper= DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    txtName.text=product.name;
    txtDescription.text=product.description;
    txtUnitPrice.text=product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
              onSelected: selectProcess,
              itemBuilder: (BuildContext context)=> <PopupMenuEntry<Options>>[
                PopupMenuItem<Options>(
                    value: Options.update,
                    child: Text("Update")
                ),
                PopupMenuItem<Options>(
                    value: Options.delete,
                    child: Text("Delete")
                ),
              ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField()
        ],
      ),
    );
  }

  Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: txtName.text),
      controller: txtName,
    );
  }

  Widget buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: txtDescription.text),
      controller: txtDescription,
    );
  }

  Widget buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: txtUnitPrice.text),
      controller: txtUnitPrice,
    );
  }



  void selectProcess(Options value) async{
    print(value);
    switch(value){
      case Options.delete:
        await dbHelper.delete(product);
        Navigator.pop(context,true);
        break;
      case Options.update:
        await dbHelper.update(Product(id:product.id, name: txtName.text, description: txtDescription.text, unitPrice: int.parse(txtUnitPrice.text)));
        print(value);
        print(txtName.text);print(txtUnitPrice.text);print(txtDescription.text);
        Navigator.pop(context,true);
        break;
      default:
    }

  }

}