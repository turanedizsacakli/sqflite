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

enum Options{delete,update}

class _ProductDetailState extends State {

  Product product;
  _ProductDetailState(this.product);
  var dbHelper= DbHelper();

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

  buildProductDetail() {}

  void selectProcess(Options value) async{
    switch(value){
      case Options.delete:
        await dbHelper.delete(product);
        Navigator.pop(context,true);
        break;
      default:
    }

  }

}