import 'package:flutter/material.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_detail.dart';
import '../data/dbHelper.dart';
import '../models/product.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbHelper= DbHelper();
  //whyyyyyyyyyy?
  late List<Product> products;
  int productCount=0;

  @override
  void initState() {
    getProducts();
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     appBar: AppBar(
       title: Text("Product List"),
     ),
     body: buildProductList(),
     floatingActionButton: FloatingActionButton(
       onPressed: (){goToProductAdd();},
       child: Icon(Icons.add),
       tooltip: "Add New Product",
     ),
   );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.black12,child: Text("P"),),
                title: Text(products[position].name!),
              subtitle: Text(products[position].description!),
              onTap: (){goToDetail(this.products[position]);},
            ),
          );
        });
  }

  void goToProductAdd() async {
   bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductAdd()));
   if(result != null){
     if(result==true){
       getProducts();
     }
   }
  }
  void getProducts() async {
    var productsFuture =dbHelper.getProducts();
    productsFuture.then((data){

      setState((){
        products=data!;
        productCount=data.length;
      });

    });
  }

  void goToDetail(Product product) async {
    bool result= await Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(product)));
    if(result != null){
      if(result==true){
        getProducts();
      }
    }
  }
}
