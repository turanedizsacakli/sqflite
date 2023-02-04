import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/product.dart';

class DbHelper{

  static const int _version=1;
  static const String _dbName="etrade.db";

  static Future<Database> _getDB () async{
    return openDatabase(join(await getDatabasesPath(),_dbName),
    onCreate: (db, version) async=> await db.execute("Create Table products(id integer primary key, name text, description text, unitPrice integer);"),
    version: _version
    );
  }
  //late Database _db;
  /*static Future<Database> initializeDb() async {
    String dbPath= join(await getDatabasesPath(),"etrade.db");
    var eTradeDb = await openDatabase(dbPath,version: 1,onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async{
    await db.execute("Create Table products(id integer primary key, name text, description text, unitPrice integer)");
  }*/


  Future<List<Product>?> getProducts() async{
    final db =await _getDB();

    final List<Map<String,dynamic>> maps=await db.query("products");
    if(maps.isEmpty){
      return null;
    }
    return List.generate(maps.length, (index) {
      return Product.fromJson(maps[index]);
    });
  }

  Future<int> insert(Product product) async {
    final db =await _getDB();
    return await db.insert("products", product.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);

  }

  Future<int> delete(Product product) async {
    final db =await _getDB();
    //return await db.rawDelete("delete from products where id=$id"); direkt sql sorgusu...
    return await db.delete("products", where: "id=?", whereArgs: [product.id]);
  }

  Future<int> update(Product product) async {
    final db =await _getDB();
    return await db.update("products", product.toJson(),where: "id=?", whereArgs: [product.id],conflictAlgorithm: ConflictAlgorithm.replace);
  }
}